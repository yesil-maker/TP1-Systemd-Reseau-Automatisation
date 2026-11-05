# TP3 - Sécurisation d'un serveur Linux

## Requêtes d'investigation

### journalctl -u sshd.service

Permet d'afficher les événements liés au service SSH.

### journalctl _SYSTEMD_UNIT=sshd.service

Permet d'afficher les connexions acceptées ou refusées.

### journalctl --facility=authpriv

Permet de consulter les événements d'authentification.

### lastb

Permet d'afficher les tentatives de connexion échouées.

### last

Permet d'afficher les dernières connexions réussies.

---

## Problèmes rencontrés

### Changement de port SSH non appliqué

Le serveur continuait à écouter sur le port 22

## Solution : Recréation du fichier :
10-helios-hardening.conf
et vérification avec :
sshd -t

##PermitRootLogin toujours à yes
Un fichier supplémentaire :
"01-permitrootlogin.conf" écrasait la configuration.
Solution :
rm -f /etc/ssh/sshd_config.d/01-permitrootlogin.conf

##Connexion SSH depuis Windows refusée
La clé publique n'était pas présente dans :
/root/.ssh/authorized_keys
Solution : Ajout manuel de la clé publique et correction des permissions.


