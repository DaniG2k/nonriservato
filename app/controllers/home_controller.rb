#encoding: utf-8
class HomeController < ApplicationController
  def index
    @events = Event.upcoming.order("date_begun").limit(4)
    @posts = Post.order("date_published DESC").limit(2)

    # @projects = Project.order("RANDOM()").limit(6)
    @highlights = Highlight.order("weight")


    # set_meta_tags title: 'Homepage',
    #               description: 'Non Riservato è la piattaforma online per la riconquista creativa degli spazi pubblici di Milano. Coltiva, corri, scopri, gioca, assaggia: fai da te una città a misura di tutti!',
    #               og: {
    #                 title:            'Homepage',
    #                 description:      'Non Riservato è la piattaforma online per la riconquista creativa degli spazi pubblici di Milano. Coltiva, corri, scopri, gioca, assaggia: fai da te una città a misura di tutti!',
    #                 url:              request.original_url,
    #                 image:            "http://nonriservato.net/assets/header_calendario.jpg"
    #               },
    #               fb:{
    #                 app_id:          '673640696130600'
    #               }
  end
end
