# Labobine – Guide du projet

## Aperçu
Labobine est une application Ruby on Rails qui permet de découvrir des films via l'API The Movie Database (TMDb), de consulter leur fiche détaillée puis de les organiser dans des listes personnelles protégées par authentification. Les utilisateurs disposent également d'un tableau de bord pour gérer leur profil et retrouver rapidement leurs listes favorites. L'interface s'appuie sur Bootstrap 5, Stimulus et la librairie Splide pour proposer une expérience responsive sur desktop comme sur mobile.

## Fonctionnalités principales
- **Découverte de films populaires** : la page d'accueil consomme le service `Tmdb::TopRatedMoviesService` pour afficher une sélection de films les mieux notés, ainsi qu'une bannière issue des films enregistrés en base de données.【F:app/controllers/movies_controller.rb†L4-L16】【F:app/views/movies/index.html.erb†L1-L68】
- **Recherche et exploration** : un moteur de recherche paginé (Kaminari) interroge l'API TMDb par titre pour découvrir de nouveaux films via le service `Tmdb::MovieSearchService`.【F:app/controllers/explorer_controller.rb†L4-L14】【F:app/services/tmdb/movie_search_service.rb†L6-L31】
- **Fiches détaillées** : chaque film affiche son synopsis et permet, une fois connecté, de l'ajouter à une liste avec une note et un commentaire personnels grâce au service `Tmdb::MovieDetailsService` et au formulaire de signet (bookmark).【F:app/controllers/movies_controller.rb†L1-L20】【F:app/views/movies/show.html.erb†L1-L24】
- **Gestion de listes personnelles** : création, consultation et suppression de listes liées à un utilisateur authentifié (Devise), avec possibilité de supprimer individuellement un film enregistré dans une liste.【F:app/controllers/lists_controller.rb†L1-L37】【F:app/controllers/bookmarks_controller.rb†L1-L28】【F:app/views/lists/show.html.erb†L1-L37】
- **Tableau de bord utilisateur** : affichage centralisé des informations de profil et du portrait téléversé via Active Storage et Cloudinary.【F:app/controllers/dashboards_controller.rb†L1-L8】【F:app/views/dashboards/index.html.erb†L1-L27】

## Architecture et pile technique
- **Langage & Framework** : Ruby 3.3.5, Rails 7.1.5.2 (importmap, Turbo, Stimulus).【F:Gemfile†L1-L24】
- **Base de données** : PostgreSQL avec modèles `User`, `List`, `Movie`, `Bookmark` et Active Storage pour les fichiers associés.【F:db/schema.rb†L15-L77】
- **Authentification** : Devise pour la gestion des comptes, sessions et récupération de mot de passe.【F:Gemfile†L46-L64】【F:app/models/user.rb†L1-L10】
- **Gestion des médias** : Active Storage configuré sur le service Cloudinary en développement et production.【F:config/environments/development.rb†L30-L38】【F:config/storage.yml†L6-L19】
- **Front-end** : Bootstrap 5, Font Awesome, Stimulus (`splide_controller`) et Splide (CDN) pour les carrousels responsive.【F:Gemfile†L46-L60】【F:app/javascript/controllers/splide_controller.js†L1-L15】【F:app/views/layouts/application.html.erb†L1-L66】
- **Services externes** : Intégration TMDb via classes `Tmdb::BaseService` et dérivées (TopRated, MovieDetails, MovieSearch, etc.) utilisant un token Bearer API.【F:app/services/tmdb/base_service.rb†L1-L26】【F:app/services/tmdb/top_rated_movies_service.rb†L1-L17】
- **Pagination** : Kaminari pour paginer les résultats de recherche.【F:app/controllers/explorer_controller.rb†L4-L14】

## Prérequis
- Ruby 3.3.5 et Bundler
- PostgreSQL 13+ et un utilisateur disposant des droits de création de base de données
- Yarn ou npm (facultatif, l'application utilise importmap)
- Compte TMDb avec token d'API v4 (Bearer)
- Compte Cloudinary pour l'hébergement des images (facultatif pour un premier lancement, mais requis pour l'upload via Active Storage)

## Installation
1. **Cloner le dépôt**
   ```bash
   git clone <URL_DU_DEPOT>
   cd whatch-list
   ```
2. **Installer les dépendances Ruby**
   ```bash
   bundle install
   ```
   (Vous pouvez également exécuter `bin/setup` pour automatiser l'installation, la préparation de la base et le nettoyage des caches.)【F:bin/setup†L1-L35】
3. **Configurer la base de données**
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```
4. **(Optionnel) Charger les données de démonstration**
   ```bash
   bin/rails db:seed
   ```
   Le seed crée un utilisateur de test et plusieurs films classiques utilisés pour alimenter la bannière d'accueil.【F:db/seeds.rb†L1-L113】

## Configuration des variables d'environnement
L'application s'appuie sur `dotenv-rails`. Créez un fichier `.env` à la racine avec les clés suivantes :
```bash
TMDB_BEARER_TOKEN=xxx             # Token API v4 TMDb
CLOUDINARY_URL=cloudinary://...   # URL complète fournie par Cloudinary (alternative aux clés séparées)
CLOUDINARY_CLOUD_NAME=xxx
CLOUDINARY_API_KEY=xxx
CLOUDINARY_API_SECRET=xxx
```
- `TMDB_BEARER_TOKEN` est requis pour toutes les requêtes à l'API TMDb.【F:app/services/tmdb/base_service.rb†L8-L25】
- Les trois variables Cloudinary sont nécessaires si vous souhaitez permettre aux utilisateurs de téléverser une photo de profil ou d'illustrer leurs listes.【F:config/storage.yml†L10-L19】
- En production, configurez également `WHATCH_LIST_DATABASE_PASSWORD` (utilisé dans `config/database.yml`).【F:config/database.yml†L13-L54】

## Lancement de l'application
- **Développement** :
  ```bash
  bin/rails server
  ```
  L'application est accessible sur http://localhost:3000. La configuration inclut `letter_opener` comme méthode de livraison d'emails pour consulter les messages sortants dans le navigateur.【F:config/environments/development.rb†L70-L77】
- **Avec Docker** : un `Dockerfile` multi-étapes est fourni pour bâtir une image de production. Exemple :
  ```bash
  docker build -t labobine .
  docker run --env-file .env -p 3000:3000 labobine
  ```
  (Assurez-vous de fournir les variables d'environnement décrites plus haut.)【F:Dockerfile†L1-L56】

## Gestion des comptes et de l'accès
- L'inscription et la connexion sont gérées par Devise (`/users/sign_up`, `/users/sign_in`).
- La plupart des fonctionnalités (création de listes, ajout de films, consultation du tableau de bord) nécessitent d'être connecté grâce aux filtres `before_action :authenticate_user!`.【F:app/controllers/lists_controller.rb†L2-L37】【F:app/controllers/bookmarks_controller.rb†L2-L28】【F:app/controllers/dashboards_controller.rb†L1-L8】

## Tests
RSpec est installé mais aucun test n'est encore défini dans `spec/`. Vous pouvez initialiser votre propre suite via :
```bash
bundle exec rspec
```
(Ajoutez vos fichiers de spécifications dans le dossier `spec/`.)

## Structure des données
Les principales tables et relations sont résumées ci-dessous :
- `users` : authentification Devise + informations de profil (âge, ville, description, etc.).
- `lists` : listes de films associées à un utilisateur (et illustrées via Active Storage).
- `movies` : films enregistrés localement pour améliorer l'affichage de la page d'accueil (inclut `tmdb_id`).
- `bookmarks` : association entre un film TMDb et une liste, avec note (`rating`) et commentaire facultatif (limité à 550 caractères).【F:db/schema.rb†L33-L77】【F:app/models/bookmark.rb†L1-L6】

## Ressources front-end
- Les styles personnalisés sont regroupés dans `app/assets/stylesheets` (structure SCSS par composants et pages).【F:app/assets/stylesheets/application.scss†L1-L20】
- Les contrôleurs Stimulus se trouvent dans `app/javascript/controllers/`; `splide_controller` initialise le carrousel Splide exposé via CDN dans le layout principal.【F:app/javascript/controllers/splide_controller.js†L1-L15】【F:app/views/layouts/application.html.erb†L1-L48】

## Aller plus loin
- Ajouter des tests système et unitaires (RSpec, Capybara) pour sécuriser les parcours critiques.
- Étendre l'exploration TMDb (recherche par mots-clés, genres) à l'aide des services déjà disponibles (`SearchMoviesByKeywordService`, `MoviesByKeywordService`).【F:app/services/tmdb/search_movies_by_keyword_service.rb†L1-L14】【F:app/services/tmdb/movies_by_keyword_service.rb†L1-L35】
- Mettre en place un hébergement (Render, Fly.io, Heroku) en définissant les variables d'environnement nécessaires et en forçant SSL (déjà activé en production).【F:config/environments/production.rb†L1-L60】

Bonne exploration et bon visionnage !
