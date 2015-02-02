#!/usr/bin/ruby
require 'FenetreQt.rb'

errorfic ="Erreur: #{$0} a besoin d'un seul paramètre";
if(ARGV.size != 0) then raise "#{errorfic}\n" end

app=Qt::Application.new ARGV
fen=FenetreVisualisation.new



app.exec

