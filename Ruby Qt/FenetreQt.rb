#!/usr/bin/ruby
require 'Qt'

class FenetreVisualisation < Qt::Widget
	slots :ouvrir

	def initialize
		super
		setWindowTitle("Visualisation")

		boiteV=Qt::VBoxLayout.new self
		boiteH=Qt::HBoxLayout.new 

		ouvrir=Qt::PushButton.new("Ouvrir")
		inverser=Qt::PushButton.new("Inverser")
		quitter=Qt::PushButton.new("Quitter")
		roberts=Qt::PushButton.new("Roberts")

		quitter.connect(quitter, SIGNAL(:clicked), self, SLOT(:close))
		ouvrir.connect(ouvrir, SIGNAL(:clicked), self, SLOT(:ouvrir))
		roberts.connect(roberts,SIGNAL(:clicked),self,SLOT(:roberts))

		boiteH.addWidget(ouvrir)
		boiteH.addWidget(inverser)
		boiteH.addWidget(quitter)
		boiteH.addWidget(roberts)

		boiteV.addLayout(boiteH)
		@@labelImage=Qt::Label.new
		boiteV.addWidget(@@labelImage)

		#fenAsc=Qt::ScrollArea.new
		#fenAsc.setWidget(@@labelImage)

		
		scrollArea = Qt::ScrollArea.new
		@@labelImage = Qt::Label.new
		scrollArea.setWidget(@@labelImage)
		
		vboximage = Qt::VBoxLayout.new
		vboximage.addWidget(scrollArea)
		
		boiteVAll.addLayout(vboximage)
		
		show
	end	

	def ouvrir

		fileName=Qt::FileDialog.getOpenFileName(self, "Sélection du fichier")
		if (!fileName.nil?)
			@@image=Qt::Image.new(fileName)
			pixmap=Qt::Pixmap.fromImage(image)
			@@labelImage.setPixmap(pixmap)
		end

	end

	def inverser
		for y in 0..@@image.height-1
			for x in 0..@@image.width-1
				pixel = @@image.pixel(x,y)
				@@image.setPixel(x,y,qRgb(255-qRed(pixel),255-qGreen(pixel),255-qBlue(pixel)))
			end
		end
	pixmap = Qt::Pixmap.fromImage(@@image)
	@@labelImage.setPixmap(pixmap)
	end

	def roberts
		for y in 0..@@image.height-2
			for x in 0..@@image.width-2
				pixel = @@image.pixel(x,y)
				pixelplusplus = @@image.pixel(x+1,y+1)
				pixelplusj = @@image.pixel(x+1,y)
				pixeliplus = @@image.pixel(x,y+1)

				rouge = ((qRed(pixel)-qRed(pixelplusplus)).abs + (qRed(pixelplusj)-qRed(pixeliplus)).abs)/2
				vert = ((qGreen(pixel)-qGreen(pixelplusplus)).abs + (qGreen(pixelplusj)-qGreen(pixeliplus)).abs)/2
				bleu = ((qBlue(pixel)-qBlue(pixelplusplus)).abs + (qBlue(pixelplusj)-qBlue(pixeliplus)).abs)/2
				@@image.setPixel(x,y,qRgb(rouge,vert,bleu))
			end
		end
	pixmap = Qt::Pixmap.fromImage(@@image)
	@@labelImage.setPixmap(pixmap)
	end
end 

