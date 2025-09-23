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

## Pourquoi Labobine ?
Labobine est née de la volonté d'offrir une alternative soignée aux listes de films éparpillées entre carnets, applications de notes et souvenirs. Le projet veut réunir en un même espace la découverte, la sélection et le partage de coups de cœur cinématographiques. L'expérience met l'accent sur la qualité des informations issues de TMDb, la personnalisation des listes et une navigation pensée pour les cinéphiles pressés comme pour les curieux qui explorent. La vision à long terme est de proposer un compagnon culturel qui suive vos envies au fil des saisons, vous inspire et vous incite à revoir vos classiques comme à dénicher de nouvelles pépites.

## Parcours utilisateur type
1. **Explorer** — L'utilisateur arrive sur la page d'accueil et se laisse guider par les recommandations mises en avant, illustrées par des visuels riches et des extraits de synopsis. Une recherche rapide lui permet de trouver un titre précis ou de découvrir des films liés à un mot-clé.
2. **Sélectionner** — En consultant la fiche détaillée d'un film, il lit le résumé, visionne les informations clés et décide de l'ajouter à l'une de ses listes, avec la possibilité d'y adjoindre sa propre note et un commentaire.
3. **Organiser** — Il crée des listes thématiques (voyage, soirées doudou, chefs-d'œuvre oubliés, etc.) et les enrichit d'illustrations personnalisées. Chaque liste devient un espace soigné qu'il pourra partager ou garder pour lui.
4. **Revenir** — Le tableau de bord centralise ses listes et son profil, l'invitant à revenir régulièrement pour continuer sa veille, préparer une projection ou simplement retrouver des idées de visionnage.

## Exemples d'usages
- **Préparer une soirée cinéma entre amis** : créer une liste collaborative (fonctionnalité à venir) avec les propositions de chacun et voter pour la sélection finale.
- **Garder trace d'un marathon de festival** : noter les films vus, ajouter ses impressions à chaud et conserver un historique fidèle de ses découvertes.
- **Composer une bibliothèque éducative** : regrouper des films par thématique (histoire, écologie, animation), y associer des commentaires pédagogiques et partager la liste avec une classe ou un club.
- **Planifier ses sorties en salle** : enregistrer les sorties à venir repérées grâce aux tendances TMDb et recevoir des rappels pour ne rien manquer.

## Objectifs utilisateurs
Labobine s'adresse aux amateurs de cinéma souhaitant :
- Centraliser leurs films favoris dans des listes vivantes plutôt que statiques.
- Ajouter une couche personnelle (notes, commentaires, visuels) à des données enrichies automatiquement.
- S'appuyer sur une base fiable pour découvrir de nouveaux films sans devoir multiplier les services.
- Retrouver rapidement leurs inspirations grâce à un tableau de bord simple et une interface responsive.

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
- Consulter le [guide technique détaillé](docs/guide-technique.md) pour retrouver l'installation, la configuration et les commandes de lancement.
- Ajouter des tests système et unitaires (RSpec, Capybara) pour sécuriser les parcours critiques.
- Étendre l'exploration TMDb (recherche par mots-clés, genres) à l'aide des services déjà disponibles (`SearchMoviesByKeywordService`, `MoviesByKeywordService`).【F:app/services/tmdb/search_movies_by_keyword_service.rb†L1-L14】【F:app/services/tmdb/movies_by_keyword_service.rb†L1-L35】
- Mettre en place un hébergement (Render, Fly.io, Heroku) en définissant les variables d'environnement nécessaires et en forçant SSL (déjà activé en production).【F:config/environments/production.rb†L1-L60】

Bonne exploration et bon visionnage !
