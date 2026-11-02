TP1 - Configuration avancée d'un serveur Linux

Mission 1 : Systemd
Analyse du démarrage

Avant optimisation
boot-avant

Après optimisation
boot-apres

Service helios-collect
Création du service :

helios-collect.service
utilisateur système helios
redémarrage automatique
Test de redémarrage
Kill du processus :

kill -9 PID
Résultat :

kill9

Le service est automatiquement redémarré par systemd.

Mission 2 : Réseau avancé
Bond active-backup
Création du bond :

bond0
enp0s9
enp0s10
Vérification
bond

VLAN 42
Création :

bond0.42
vlan42
Capture tcpdump
vlan42

Difficultés rencontrées
Problème 1
Les deux VM possédaient la même adresse IP :

10.42.0.10
Solution
Modification de l'IP de srv-edge :

nmcli con mod enp0s8 ipv4.addresses 10.42.0.11/24
Problème 2
Erreur :

awk : variable sans liaison
Cause
Erreur de copier-coller dans helios-collect.sh

Solution
Correction de la syntaxe awk.

Problème 3
Connexion SSH impossible.

Solution
Activation du service :

systemctl enable --now sshd
Mission 3 : Automatisation
Script helios-archive
Fonctionnalités :

verrouillage
journalisation
codes retour
archivage gzip
Codes retour observés
Code	Signification
0	Succès
2	Verrou déjà pris
3	Source absente
Timer systemd
Timer :

helios-archive.timer
Vérification
timer
