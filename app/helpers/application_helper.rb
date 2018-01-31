#encoding: utf-8
module ApplicationHelper

  def nav_order
    [["events", "calendario"], ["projects", "progetti"], ["organizations", "network"], ["workshops", "workshop"], ["posts", "blog"]]
  end
  
  def is_active?(page_name)
      stripped_controller = params[:controller].split("/").last
      current_route = request.env['PATH_INFO'].split("/").last
      if @current_tab.nil?
        " active" if (params[:action] == page_name) || (page_name == "home" && (stripped_controller == page_name)) ||  ((current_route == page_name))
      else
        " active" if page_name == @current_tab
      end
  end
  
  def asset_url asset
    "#{request.protocol}#{request.host_with_port}#{asset_path(asset)}"
  end
  
  def default_meta_tags
    {
      site: 'NonRiservato',
      title: 'Homepage',
      description: 'Non Riservato è la piattaforma online per la riconquista creativa degli spazi pubblici di Milano. Coltiva, corri, scopri, gioca, assaggia: fai da te una città a misura di tutti!',
      og: {
        title:            :title,
        description:      :description,
        type:             "website", 
        url:              request.original_url,
        image:            "http://nonriservato.net/assets/header_calendario.jpg"
          },
      fb:{
        app_id:          '673640696130600'
      }
    }
  end
  
  
  
  def admin_nav_order
    if current_organization.try(:admin?)
      [["edit_profile", "profilo"], ["projects", "progetti"], ["events","eventi"], ["workshops", "workshops"], ["posts","post"], ["organizations","enti"]]
    else
      [["edit_profile", "profilo"], ["projects", "progetti"], ["events","eventi"], ["partners","partner nr"], ["external_partners","partner istituzionali"]]
    end
  end
  
  def admin_namespace?
    controller_path.split('/').first == "admin" ? true : false
  end

  def namespace
    controller_path.split('/').first == "admin" ? "admin" : ""
  end

  def prepopulate_organizations
    content_tag( :script, render('/admin/organizations/prepopulate'), :type => "text/javascript")
  end
  
  def prepopulate_external_organizations
    content_tag(:script, render('/admin/external_organizations/prepopulate_project'),:type => "text/javascript")
  end  

  def prepopulate_projects
    content_tag( :script, render('/admin/projects/prepopulate'),:type => "text/javascript")
  end
  
  def prepopulate_external_partners
    content_tag( :script, render('/admin/external_organizations/prepopulate_organization'),:type => "text/javascript")
  end

  def ensure_url(url)
    if (url.split("http://").size > 1) || (url.split("https://").size > 1)
      return url
    else
      return "http://#{url}"
    end
  end
  
  def last_if_module(counter, elements_per_row)
    return "last" if ((counter + 1) % elements_per_row == 0 && counter != 0)
  end

  def markdown(key)
      markdown = raw (RDiscount.new(I18n.t(key)).to_html)      
  end

  def markdown_d(key)
      markdown = raw (RDiscount.new(key).to_html)
  end
    



end
