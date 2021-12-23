#!/bin/bash

# ce que ce script fait : il synchronise au même niveau que lui le dossier "public" écrit en minuscule et le fout sur Aws.

# 22/2/21 - initial design

echo "*****************************************************************************************"
echo "*                               BONJOUR VIANNEY                                         *"
echo "* Synchronisation du contenu du dossier './public' ===>  s3://dr.vianney.gandillot.com  *"
echo "* Cela va DEFINITIVEMENT remplacer le contenu de ce qui est actuellement publié par le  *"
echo "* contenu du dossier ./public. Cette opération ne POURRA PAS ête annulée.               *"
echo "*****************************************************************************************"
echo ""
if [ -d "./public" ]
then 
    echo "Les fichiers et dossiers qui seront envoyés sont :"
    echo ""
    ls -C ./public
else 
    echo "ERREUR : Je n'ai pas de dossier nommé 'public' sous la main !? Bye !"
    sleep 3
    exit 1
fi

echo ""
echo "ES-TU CERTAIN DE VOULOIR FAIRE CELA ? (tape oui, en minusucle, pour confirmer)"
read reponse
if [ "$reponse" == "oui" ]
then
    echo "Ok, tu l'auras voulu  ;-)"
else
    echo "Tu n'as pas tapé 'oui', donc j'arrête tout. Bye !"
    sleep 3
    exit 2
fi


SECONDS=0
echo "================================================================================="
echo "Démarrage de la synchonisation"
echo "================================================================================="

aws --version
# synchronize public to s3, delete unecessary files in s3, mark evrything as publicly readeable.
aws s3 sync ./public/ s3://dr.vianney.gandillot.com --delete --acl=public-read

echo "================================================================================="
echo "Synchronisation terminée en $SECONDS seconds"
echo "================================================================================="

sleep 3




