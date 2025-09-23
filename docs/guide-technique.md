# Guide technique Labobine

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
   (Vous pouvez également exécuter `bin/setup` pour automatiser l'installation, la préparation de la base et le nettoyage des caches.)
3. **Configurer la base de données**
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```
4. **(Optionnel) Charger les données de démonstration**
   ```bash
   bin/rails db:seed
   ```
   Le seed crée un utilisateur de test et plusieurs films classiques utilisés pour alimenter la bannière d'accueil.

## Configuration des variables d'environnement
L'application s'appuie sur `dotenv-rails`. Créez un fichier `.env` à la racine avec les clés suivantes :
```bash
TMDB_BEARER_TOKEN=xxx             # Token API v4 TMDb
CLOUDINARY_URL=cloudinary://...   # URL complète fournie par Cloudinary (alternative aux clés séparées)
CLOUDINARY_CLOUD_NAME=xxx
CLOUDINARY_API_KEY=xxx
CLOUDINARY_API_SECRET=xxx
```
- `TMDB_BEARER_TOKEN` est requis pour toutes les requêtes à l'API TMDb.
- Les trois variables Cloudinary sont nécessaires si vous souhaitez permettre aux utilisateurs de téléverser une photo de profil ou d'illustrer leurs listes.
- En production, configurez également `WHATCH_LIST_DATABASE_PASSWORD` (utilisé dans `config/database.yml`).

## Lancement de l'application
- **Développement** :
  ```bash
  bin/rails server
  ```
  L'application est accessible sur http://localhost:3000. La configuration inclut `letter_opener` comme méthode de livraison d'emails pour consulter les messages sortants dans le navigateur.
- **Avec Docker** : un `Dockerfile` multi-étapes est fourni pour bâtir une image de production. Exemple :
  ```bash
  docker build -t labobine .
  docker run --env-file .env -p 3000:3000 labobine
  ```
  (Assurez-vous de fournir les variables d'environnement décrites plus haut.)
