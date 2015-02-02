#!/usr/bin/ruby
require 'FenetreVisualisation.rb'
require 'fichierCSV_vEt.rb'

# ===================================================================
#                         Programme principal
# ===================================================================

# Vérification de la syntaxe d'appel et renommage des paramètres
syntaxe ="Syntaxe: #{$0} nomFichier";
if(ARGV.size != 1) then raise "#{syntaxe}\n" end
nomFic=ARGV[0]

# nblig = FichierCSV.NbLignes(nomFic)
# puts "Nb lignes: ",nblig

# ficCSV = FichierCSV.new(nomFic)
# puts "tab",ficCSV.tableau

interf=FenetreVisualisation.new(nomFic)	
