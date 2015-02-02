#!/usr/bin/ruby
require 'gtk2'
require 'fichierCSV_vEt.rb'

class FenetreVisualisation

	def initialize(nomFic)

		@ficCSV=FichierCSV.new(nomFic)
				
		Gtk.init
	
		fenetre=Gtk::Window.new
		fenetre.set_title("Répartition")
		fenetre.set_default_size(600,400)
		fenetre.signal_connect("destroy"){Gtk.main_quit()}

		table = Gtk::Table.new(FichierCSV.NbLignes(nomFic),@ficCSV.entete.size)

		#Remplissage entete
		j=0	
		while j<@ficCSV.entete.size
			lbl=Gtk::Label.new(@ficCSV.entete[j])
                	table.attach(lbl,j,j+1,0,1)
			j+=1
		end

		#Remplissage tableau
		i=0
                while i<(FichierCSV.NbLignes(nomFic)-1)
                        lbl=Gtk::Label.new(@ficCSV.tableau[i][0])
                        table.attach(lbl,0,1,i+1,i+2)
                        lbl=Gtk::Label.new(@ficCSV.tableau[i][1])
                        table.attach(lbl,1,2,i+1,i+2)

			br1=Gtk::RadioButton.new(i.to_s)
                        table.attach(br1,2,3,i+1,i+2)
                        br2=Gtk::RadioButton.new(br1,i.to_s)
                        table.attach(br2,3,4,i+1,i+2)
			if(@ficCSV.tableau[i][2]=="1")
				br1.active=true
			else

				br1.active=false
			end
			if(@ficCSV.tableau[i][3]=="1")
				br2.active=true
			else
				br2.active=false
			end

			br1.signal_connect("clicked") {@ficCSV.changerBooleen(br1.label.to_i,2)}
			br2.signal_connect("clicked") {@ficCSV.changerBooleen(br2.label.to_i,3)}

			i+=1
                end

		#Bouton quitter
		buttonQuit = Gtk::Button.new("Quitter")
		buttonQuit.signal_connect("clicked"){Gtk.main_quit()} 

		#Bouton sauver
		buttonSave = Gtk::Button.new("Sauver")
		buttonSave.signal_connect("clicked"){@ficCSV.sauverFichier("save.csv")} 

		#Bouton repartition
		buttonRepart = Gtk::Button.new("Repartition")
		buttonRepart.signal_connect("clicked"){repartition(fenetre)}

		#Boite H de bouton
		boiteH = Gtk::HBox.new(0,0)
		boiteH.pack_start(buttonSave, false, false,0)
		boiteH.pack_start(buttonRepart, false, false,0)
		boiteH.pack_start(buttonQuit, false, false,0)

		tableBox = Gtk::ScrolledWindow.new(nil, nil)
		tableBox.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
		tableBox.add_with_viewport(table)

		#Boite V
		boiteV = Gtk::VBox.new(false, 0)
		boiteV.pack_start(boiteH, false, false,0)
		boiteV.pack_start(tableBox, true, true,0)
		fenetre.add(boiteV)


		fenetre.show_all	
		Gtk.main
	end

	def repartition(fen)
		repartition = "LSR : "+@ficCSV.calcNb(2).to_s+"\nTMMD : "+@ficCSV.calcNb(3).to_s+"\n"
		dialog = Gtk::MessageDialog.new(fen,Gtk::MessageDialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::INFO, 		Gtk::MessageDialog::BUTTONS_OK, repartition);
		dialog.run
		dialog.destroy
	end


end
