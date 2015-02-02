#!/usr/bin/ruby

# ===================================================================
#                   Primitives de gestion des fichiers
# ===================================================================

class FichierCSV
	# Nombre de colonnes d'un fichier bien formaté
	@@nbCol=4

	# Tableau correspondant à l'entête
	attr_accessor :entete	
	# Tableau à deux dimensions correspondants aux données
	attr_accessor :tableau	

	# Lecture d'un fichier au format CSV
	# ---------------------------------------------------------------
	# Paramètres:
	#  0: nom du fichier
	def initialize(nom)
		# Ouverture du fichier d'entrée
		f=File.open(nom, "r")

		# Lecture de la première ligne qui contient le nom des groupes
		if (ligne=lireLigne(f))
				@entete = ligne.split(/;/)
		end
		if(@entete.size != @@nbCol)
			raise "Erreur premiere ligne $ligne"
		end

		# Lecture des étudiants (un par ligne)
		@tableau=Array.new ;
		while( !f.eof() )
			if(ligne=lireLigne(f) )
				    champs=ligne.split(/;/)
				    @tableau.push(champs)
			end
		end
		f.close
	end

	# Calcul du nombre de lignes d'un fichier
	# ---------------------------------------------------------------
	# Paramètres:
	#  0: nom du fichier
	# Retour:
	#  Le nombre de lignes du fichier
	def FichierCSV.NbLignes(nom)
		cpt=0
		f=File.open(nom, "r")
		begin
			while line=f.readline
				cpt+=1
			end
			rescue EOFError
		end
		return cpt
	end

	# Lecture d'une ligne valide
	# ---------------------------------------------------------------
	# Paramètres:
	#  0: handle du fichier d'entrée
	# Retour:
	#  La ligne valide lue ou vide en fin de fichier
	def lireLigne(f)
		while ligne=f.readline
				ligne.sub!(/\s*$/,"")       # Suppression des blans en fin de ligne

				# On élimine les lignes vides et les lignes commençant par un symbole dièse
				if ((ligne !~ /^\s*#/) && (ligne !~ /^\s*$/))
				    return(ligne)
				end
		end
		return "" 
	end	

	# Sauvegarde d'un fichier au format CSV
	# ------------------------------------------------------------------------------
	# Paramètres:
	#  0: nom du fichier
	#  1: référence au tableau décrivant l'entête
	#  2: référence vers la SimpleList de l'interface graphique
	def sauverFichier(nom)
		# Ouverture du fichier de sauvegarde
		f=File.open(nom,"w")
		# Sauvegarde de l'entête
		f.write(@entete.join(";")+"\n")
		# Sauvegarde des données
		@tableau.each { |ligne|
			f.write(ligne.join(";")+"\n")
		}
		f.close
	end

	#Compte le nombre de vrai dans une colonne du tableau
	def calcNb(col)
		nb = 0;
		@tableau.each { |ligne|
			if ligne[col]=="1"
				nb+=1
			end
		}
		return nb
	end

	# Inversion d'un booléen
	# ------------------------------------------------------------------------------
	def changerBooleen(nl,nc)
		print "Changement booléen, ligne: #{nl}, colonne: #{nc}\n"
		if @tableau[nl][nc] = "1"
			@tableau[nl][nc]= "0"
		else
			@tableau[nl][nc]= "1"
		end
	end

end
