# Script d'installation automatisée de logiciels

Ce script PowerShell permet d'automatiser l'installation de plusieurs logiciels sur un poste Windows. Il offre différentes options pour installer des logiciels spécifiques ou effectuer des configurations personnalisées selon les besoins.

## Prérequis avant d'exécuter le script

1. Ouvrir PowerShell en mode administrateur.
2. Exécuter la commande suivante pour permettre l'exécution des scripts non signés :
   ```powershell
   Set-ExecutionPolicy Unrestricted

3. Naviguer vers le script et l'exécuter.

## Fichiers d'installation nécessaires

Le script s'appuie sur les fichiers d'installation suivants, qui doivent être présents dans le répertoire

**SOFTWARES :**
  - 432WindowsAgentSetup_VALID_UNTIL_2025_02_25.exe
  - FortiClientVPNSetup.exe
  - TeamsSetup_c_w_.exe
  - CHECKPOINT EDR AND VPN\EPS_2024-06-02T23 50 27.479_V88.00.0187.exe
  - AdobeReaderInstaller.exe
  - OFFICE365\OfficeSetup.exe
  - OFFICE365\Project.exe
  - NITRO PRO\NITRO PRO 14\nitro_pro14_x64.msi
  - chrome_install.ps1

# Utilisation
## Menu principal

Le script présente un menu avec les options suivantes :

  - 1-9 : Installation de logiciels spécifiques (ex : Teams, FortiClient, etc.)
  - A : Installer seulement les logiciels nécessaires.
  - C : Mode d'installation personnalisée (avec différents profils de configuration).
  - U : Installer les mises à jour Windows.
  - R : Redémarrer l'ordinateur.
  - X : Quitter le script.

# Mode d'installation personnalisée

Le mode d'installation personnalisée permet de choisir parmi différents profils d'installation selon les besoins de l'utilisateur :

  - Charge de projets
  - Employé avec installation de base (avec/sans VPN, avec/sans Nitro PDF)

# Avertissements

  - Ce script doit être exécuté avec les privilèges administratifs pour installer les logiciels et appliquer les mises à jour.
