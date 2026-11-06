TP1 - Configuration avancée d'un serveur Linux

Difficultés rencontrées
Problème 1
Les deux VM possédaient la même adresse IP :

10.42.0.10
Solution
Modification de l'IP de srv-edge :

nmcli con mod enp0s8 ipv4.addresses 10.42.0.11/24

Problème 2
Erreur :
Erreur de copier-coller dans les VM

Solution
Utilisation du powershell sur le pc hôte.

Problème 3
Connexion SSH impossible.

Solution
Activation du service :
systemctl enable --now sshd
