prawn_document do |pdf|

# linee verdi in header e footer  
  pdf.stroke_color "0b8800"
  pdf.line_width(2)
  pdf.line [pdf.bounds.left, pdf.bounds.top - 2], [pdf.bounds.right, pdf.bounds.top - 2]
  pdf.line [pdf.bounds.left, pdf.bounds.bottom + 11], [pdf.bounds.right, pdf.bounds.bottom + 11]
  pdf.stroke()

# Azienda - sx alto
  pdf.draw_text "Lombardia Informatica", :at =>[pdf.bounds.left, pdf.bounds.top]
# Titolo centro alto
  pdf.move_cursor_to(pdf.bounds.top + 9)
  pdf.text("Stampa assegnazione ip", :align => :center)
# Classificazione - dx alto        
  pdf.move_cursor_to(pdf.bounds.top + 6)
  pdf.text("Classificazione: uso interno", :align => :right, :size => 8)
# Progetto - sx basso
  pdf.draw_text "webip - Vlan Ip", :at =>[pdf.bounds.left, pdf.bounds.bottom], :size => 8
# Ora - centro basso
  pdf.draw_text("Data " + Time.now.strftime('%d/%m/%Y') + "  ora " +
  Time.now.strftime('%H:%M'), :at => [(pdf.bounds.right / 2) - 45, pdf.bounds.bottom], :size => 8)
  pdf.move_down(3)

  righe1 = []   
  righe1.push([ 
    "Vlan",
    "Network",
    "Netmask",
    "Host Min",
    "Host Max",
    "Host Num"
  ])        
  righe1.push([ 
    @vlan.vlan_code.to_s,
    @vlan.network,
    @vlan.netmask,
    @vlan.host_min,
    @vlan.host_max,
    @vlan.hosts_num.to_s
  ])
  righe2 = []        
  righe2.push([ 
    "Gateway",
    "DNS",    
    "Descrizione"
  ])        
  righe2.push([ 
    @vlan.gateway,
    @vlan.dns,    
    @vlan.description
  ])          
  righe3 = []   
  righe3.push([ 
    "IP",
    "Hostname",
    "Note"
  ])        
  righe3.push([ 
    @vlan_ip.ip,
    @vlan_ip.hostname,
    @vlan_ip.note
  ])        

  pdf.font_size 10
  pdf.move_down(30)
      
  pdf.table righe1, :header => true,
    :cell_style => { :borders => [:left, :right], :border_color => "969696" },
    :column_widths => {0=>90, 1=>90, 2=>90, 3=>90, 4=>90, 5=>90},
    :row_colors => ["d2e3ed", "FFFFFF"] do
    row(0).background_color = "007777"
    row(0).text_color = "ffffff"
    row(0).font_style = :bold
    columns(0..5).align = :center
    row(row_length-1).borders =[:left, :right, :bottom]
  end

  pdf.move_down(30)

  pdf.table righe2, :header => true,
    :cell_style => { :borders => [:left, :right], :border_color => "969696" },
    :column_widths => {0=>90, 1=>90, 2=>360},
    :row_colors => ["d2e3ed", "FFFFFF"] do
    row(0).background_color = "007777"
    row(0).text_color = "ffffff"
    row(0).font_style = :bold
    columns(0..2).align = :center
    row(row_length-1).borders =[:left, :right, :bottom]
  end

  pdf.move_down(30)
    
  pdf.table righe3, :header => true,
    :cell_style => { :borders => [:left, :right], :border_color => "969696" },
    :column_widths => {0=>90, 1=>90, 2=>360},
    :row_colors => ["d2e3ed", "FFFFFF"] do
    row(0).background_color = "007777"
    row(0).text_color = "ffffff"
    row(0).font_style = :bold
    columns(0..2).align = :center
    row(row_length-1).borders =[:left, :right, :bottom]
  end

end