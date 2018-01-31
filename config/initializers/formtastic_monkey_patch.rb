module Formtastic
  module Inputs
    module Base
      module Html
        def extra_html
          template.content_tag(:div, Formtastic::Util.html_safe(extra_html_text),:class => (options[:extra_html_class] || 'extra-html')) if extra_html?
        end
        
        def extra_html?
          extra_html_text.present? && !extra_html_text.kind_of?(Hash)
        end
 
        def extra_html_text
          localized_string(method, options[:extra_html], :extra_html)
        end
      end
      
      module Wrapping
        def input_wrapping(&block)
          template.content_tag(:li,
            [template.capture(&block), extra_html, error_html, hint_html].join("\n").html_safe, 
            wrapper_html_options
          )
        end
      end
    end
  end
end