function ledagui
global leda2

%Menu
%-File
leda2.gui.fig_main = figure('Units','normalized','Position',[.00 .03 1 .92],'Name',[leda2.intern.name,' ',leda2.intern.versiontxt],'KeyPressFcn','leda_keypress',...
    'MenuBar','none','NumberTitle','off','Color',leda2.gui.col.fig,'CloseRequestFcn','exit_leda');
if ispc
    maximize(leda2.gui.fig_main); %not compatible with Mac
end
leda2.gui.menu.menu_1  = uimenu(leda2.gui.fig_main,'Label','File');
leda2.gui.menu.menu_1a = uimenu(leda2.gui.menu.menu_1,'Label','Open','Callback','open_ledafile;','Accelerator','o');   %
leda2.gui.menu.menu_1b = uimenu(leda2.gui.menu.menu_1,'Label','Import Data...'); %,'Accelerator','i'
leda2.gui.menu.menu_1b4 = uimenu(leda2.gui.menu.menu_1b,'Label','BioTrace (Text Export)','Callback','import_data(''biotrace'');');
leda2.gui.menu.menu_1b3 = uimenu(leda2.gui.menu.menu_1b,'Label','Cassy Lab (.lab)','Callback','import_data(''cassylab'');');
leda2.gui.menu.menu_1b6 = uimenu(leda2.gui.menu.menu_1b,'Label','PortiLab (Text Export)','Callback','import_data(''portilab'');');
leda2.gui.menu.menu_1b6 = uimenu(leda2.gui.menu.menu_1b,'Label','PsychLab (Text Export)','Callback','import_data(''psychlab'');');
leda2.gui.menu.menu_1b7 = uimenu(leda2.gui.menu.menu_1b,'Label','VarioPort (.vpd)','Callback','import_data(''varioport'');');
leda2.gui.menu.menu_1b5 = uimenu(leda2.gui.menu.menu_1b,'Label','Vision Analyzer (Matlab Export)','Callback','import_data(''visionanalyzer'');');
leda2.gui.menu.menu_1b7 = uimenu(leda2.gui.menu.menu_1b,'Label','VitaPort (Text Export)','Callback','import_data(''vitaport'');');
leda2.gui.menu.menu_1b1 = uimenu(leda2.gui.menu.menu_1b,'Label','Matlab File','Callback','import_data(''mat'');','Separator','on');
leda2.gui.menu.menu_1b2 = uimenu(leda2.gui.menu.menu_1b,'Label','Text File [Time SC (Marker)]','Callback','import_data(''text'');');
leda2.gui.menu.menu_1b2 = uimenu(leda2.gui.menu.menu_1b,'Label','Text File [Samples SC (Marker)]','Callback','import_data(''text2'');');
leda2.gui.menu.menu_1b8 = uimenu(leda2.gui.menu.menu_1b,'Label','User-defined Data','Callback','import_data(''userdef'');','Enable','off');

leda2.gui.menu.menu_1c = uimenu(leda2.gui.menu.menu_1,'Label','Import Event-Info...'); %,'Accelerator','i'
leda2.gui.menu.menu_1c1 = uimenu(leda2.gui.menu.menu_1c,'Label','User-defined Event-Info','Callback','import_eventinfo(''userdef'')');
leda2.gui.menu.menu_1d = uimenu(leda2.gui.menu.menu_1,'Label','Export Data...');
leda2.gui.menu.menu_1d1 = uimenu(leda2.gui.menu.menu_1d,'Label','ASCII File','Callback','exportTextData');
leda2.gui.menu.menu_1e = uimenu(leda2.gui.menu.menu_1,'Label','Save','Callback','save_ledafile','Accelerator','s','Separator','on');
leda2.gui.menu.menu_1f = uimenu(leda2.gui.menu.menu_1,'Label','Save as...','Callback','save_ledafile(1)');
leda2.gui.menu.menu_1g = uimenu(leda2.gui.menu.menu_1,'Label','Exit','Callback','exit_leda','Accelerator','x','Separator','on');

%--Oldfile-list
if ~isempty(leda2.intern.prevfile)
    for i = 1:length(leda2.intern.prevfile)
        if i == 1
            leda2.gui.menu.menu_of(i) = uimenu(leda2.gui.menu.menu_1,'Label',leda2.intern.prevfile(i).filename,'Callback','open_ledafile(1)','Separator','on');
        else
            leda2.gui.menu.menu_of(i) = uimenu(leda2.gui.menu.menu_1,'Label',leda2.intern.prevfile(i).filename,'Callback',['open_ledafile(',num2str(i),')']);
        end
    end
end

%-Preprocessing
leda2.gui.menu.menu_2  = uimenu(leda2.gui.fig_main,'Label','Preprocessing');
leda2.gui.menu.menu_2a  = uimenu(leda2.gui.menu.menu_2,'Label','Cut data (keep selection)','Callback','cut_ledafile'); %,'Enable','off'
leda2.gui.menu.menu_2b  = uimenu(leda2.gui.menu.menu_2,'Label','Downsampling','Callback','downsample');
leda2.gui.menu.menu_2c  = uimenu(leda2.gui.menu.menu_2,'Label','Manual Smoothing','Callback','smooth_data','Separator','on');
leda2.gui.menu.menu_2d  = uimenu(leda2.gui.menu.menu_2,'Label','Adaptive smoothing','Callback','adaptive_smoothing');
leda2.gui.menu.menu_2e  = uimenu(leda2.gui.menu.menu_2,'Label','Apply Filter','Callback','leda_filter');
leda2.gui.menu.menu_2f  = uimenu(leda2.gui.menu.menu_2,'Label','Artifact correction','Callback','artifact_interp','Accelerator','a','Separator','on');

%-Settings
leda2.gui.menu.menu_3  = uimenu(leda2.gui.fig_main,'Label','Settings');
%leda2.gui.menu.menu_3a  = uimenu(leda2.gui.menu.menu_3,'Label','Analysis settings','Callback','ledaset');
leda2.gui.menu.menu_3b  = uimenu(leda2.gui.menu.menu_3,'Label','Visual settings','Callback','ledapref');
%leda2.gui.menu.menu_3c  = uimenu(leda2.gui.menu.menu_3,'Label','Resore default settings','Callback','restore_settings','Separator','on');

%-Analyze
leda2.gui.menu.menu_4  = uimenu(leda2.gui.fig_main,'Label','Analysis');
leda2.gui.menu.menu_4g = uimenu(leda2.gui.menu.menu_4,'Label','Decomposition Analysis (Nonnegative decovolution)','Callback','nndeco');
leda2.gui.menu.menu_4g = uimenu(leda2.gui.menu.menu_4,'Label','Continuous Decomposition Analysis (Standard deconvolution) - beta version -','Callback','sdeco');
leda2.gui.menu.menu_4f = uimenu(leda2.gui.menu.menu_4,'Label','Delete analysis','Callback','delete_fit(1)','Separator','on');

%-Tools
leda2.gui.menu.menu_5  = uimenu(leda2.gui.fig_main,'Label','Tools');
leda2.gui.menu.menu_5a = uimenu(leda2.gui.menu.menu_5,'Label','FFT','Callback','leda_fft');

%-Results
leda2.gui.menu.menu_6  = uimenu(leda2.gui.fig_main,'Label','Results');
%leda2.gui.menu.menu_6a = uimenu(leda2.gui.menu.menu_6,'Label','Export SCR-List','Callback','export_scrlist');
leda2.gui.menu.menu_6b = uimenu(leda2.gui.menu.menu_6,'Label','Export Event-Related Activation','Callback','export_era','Accelerator','e');

%-Info
leda2.gui.menu.menu_7 =  uimenu(leda2.gui.fig_main,'Label','Info');
leda2.gui.menu.menu_7a = uimenu(leda2.gui.menu.menu_7,'Label','Ledalab Website','Callback','web(''www.ledalab.de'')');
%leda2.gui.menu.menu_7b = uimenu(leda2.gui.menu.menu_7,'Label','Documentation','Callback','web(''www.ledalab.de/download/Ledalab_Documentation.pdf'',''-browser'')');
leda2.gui.menu.menu_7c = uimenu(leda2.gui.menu.menu_7,'Label','Check for updates','Callback','version_check');
leda2.gui.menu.menu_7d = uimenu(leda2.gui.menu.menu_7,'Label','About Ledalab','Callback','ledalogo','Separator','on');

%Overview (= Data Display)
dy = .78;
leda2.gui.overview.ax = axes('Units','normalized','Position',[.05 dy .87 .18],'ButtonDownFcn','leda_click(1)');
set(leda2.gui.overview.ax,'XLim',[0,60],'YLim',[0,20],'Color',[.9 .9 .9]);
set(get(leda2.gui.overview.ax,'YLabel'),'String','SC [\muS]')
set(get(leda2.gui.overview.ax,'XLabel'),'String','Time [sec]')

leda2.gui.overview.edit_max = uicontrol('Units','normalized','Style','edit','Position',[.94 dy+.155 .04 .025],'String','20','Callback','edits_cb(4)');
leda2.gui.overview.edit_min = uicontrol('Units','normalized','Style','edit','Position',[.94 dy .04 .025],'String','0','Callback','edits_cb(4)');
leda2.gui.overview.text_max = uicontrol('Units','normalized','Style','text','Position',[.94 dy+.095 .04 .025],'String','-','HorizontalAlignment','center','BackgroundColor',leda2.gui.col.fig);
leda2.gui.overview.text_min = uicontrol('Units','normalized','Style','text','Position',[.94 dy+.065 .04 .025],'String','-','HorizontalAlignment','center','BackgroundColor',leda2.gui.col.fig);


x1 = .05; x2 = .7; x3 = .75; x4 = .98;
y2 = .7; y3 = .27; y5 = .22; y6 = .19; y7 = .17; y8 = .02;

%Rangeview (= Epoch Display)
leda2.gui.rangeview.ax = axes('Units','normalized','Position',[x1 y3 x2-x1 y2-y3],'XLim',[leda2.gui.rangeview.start, leda2.gui.rangeview.start + leda2.gui.rangeview.range],'YLim',[0,20],'Color',[1 1 1],'DrawMode','fast','ButtonDownFcn','leda_click(2)');
set(get(leda2.gui.rangeview.ax,'YLabel'),'String','Skin Conductance [\muS]')
set(get(leda2.gui.rangeview.ax,'XLabel'),'String','Time [sec]')

leda2.gui.rangeview.edit_start = uicontrol('Units','normalized','Style','edit','Position',[x1 y5 .05 .025],'String',leda2.gui.rangeview.start,'HorizontalAlignment','center','Callback','edits_cb(1)');
leda2.gui.rangeview.edit_range = uicontrol('Units','normalized','Style','edit','Position',[.2 y5 .05 .025],'String',leda2.gui.rangeview.range,'HorizontalAlignment','center','Callback','edits_cb(1)');
leda2.gui.rangeview.edit_end = uicontrol('Units','normalized','Style','edit','Position',[.65 y5 .05 .025],'String',leda2.gui.rangeview.start + leda2.gui.rangeview.range,'HorizontalAlignment','center','Callback','edits_cb(2)');
leda2.gui.rangeview.slider = uicontrol('Style','Slider','Units','normalized','Position',[.05 y6 x2-x1 .02],'Min',0,'Max',1,'SliderStep',[.01 .1],'Callback','edits_cb(3)');

%Driver-Axes
leda2.gui.driver.ax = axes('Units','normalized','Position',[x1 .02 x2-x1 y7-y8],'XLim',[leda2.gui.rangeview.start, leda2.gui.rangeview.start + leda2.gui.rangeview.range],'YLim',[0,20],'Color',[1 1 1],'DrawMode','fast','ButtonDownFcn','leda_click(2)');
set(get(leda2.gui.driver.ax,'YLabel'),'String','Phasic Driver [\muS]')

%Overview-Info (= Data Info Display)
dy = .40; 
x3a = x3 + .04; x3b = x3 + .13;
leda2.gui.frame = uicontrol('Units','normalized','Style','frame','Position',[x3 dy x4-x3 .3],'String','Frame Ov','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_title = uicontrol('Units','normalized','Style','text','Position',[x3a+.01 dy+.03*8 .08 .012],'String','DATA ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1,'FontWeight','bold');
leda2.gui.text_N = uicontrol('Units','normalized','Style','text','Position',[x3a dy+.03*7 .08 .012],'String','N: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_time = uicontrol('Units','normalized','Style','text','Position',[x3a dy+.03*6 .08 .012],'String','Time: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_smplrate = uicontrol('Units','normalized','Style','text','Position',[x3a dy+.03*5 .08 .012],'String','Freq: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_conderr = uicontrol('Units','normalized','Style','text','Position',[x3a dy+.03*4 .08 .012],'String','Error: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_Nevents = uicontrol('Units','normalized','Style','text','Position',[x3a dy+.03*3 .08 .012],'String','Events: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_title2 = uicontrol('Units','normalized','Style','text','Position',[x3b+.01 dy+.03*8 .08 .012],'String','FIT ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1,'FontWeight','bold');
leda2.gui.text_tau = uicontrol('Units','normalized','Style','text','Position',[x3b dy+.03*7 .08 .012],'String','Tau: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
%leda2.gui.text_adjR2 = uicontrol('Units','normalized','Style','text','Position',[x3b dy+.03*6 .08 .012],'String','Adj. R2: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_mse = uicontrol('Units','normalized','Style','text','Position',[x3b dy+.03*6 .08 .012],'String','MSE: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_rmse = uicontrol('Units','normalized','Style','text','Position',[x3b dy+.03*5 .08 .012],'String','RMSE: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_nPhasic = uicontrol('Units','normalized','Style','text','Position',[x3b dy+.03*4 .08 .012],'String','SCRs: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.text_nTonic = uicontrol('Units','normalized','Style','text','Position',[x3b dy+.03*3 .08 .012],'String','TPs: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1);
%leda2.gui.text_df = uicontrol('Units','normalized','Style','text','Position',[x3b dy+.03*1 .06 .012],'String','DF: ','HorizontalAlignment','left','BackgroundColor',leda2.gui.col.frame1,'Visible','off');

%Event Info Display
dx1 = .75; dx2 = dx1+ .03; dx3 = dx2 + .08;
leda2.gui.eventinfo.frame = uicontrol('Units','normalized','Style','frame','Position',[dx1 y6 x4-x3 .15],'String','Frame 2','BackgroundColor',leda2.gui.col.frame1);
leda2.gui.eventinfo.text_title = uicontrol('Units','normalized','Style','text','Position',[dx1+.005 y6+.125 .2 .02],'String','Events','HorizontalAlignment','left','FontSize',8,'BackgroundColor',leda2.gui.col.frame1,'FontWeight','bold');
leda2.gui.eventinfo.txtlab_eventnr  = uicontrol('Units','normalized','Style','text','Position',[dx2 y6+.09 .07 .02],'String','Eventnr:','BackgroundColor',leda2.gui.col.frame1,'HorizontalAlignment','left');
leda2.gui.eventinfo.butt_prevevent  = uicontrol('Units','normalized','Style','pushbutton','Position',[dx1+.1 y6+.095 .03 .025],'String','<','BackgroundColor',[.7 .7 .8],'HorizontalAlignment','center','Callback','edits_cb(6)');
leda2.gui.eventinfo.butt_nextevent  = uicontrol('Units','normalized','Style','pushbutton','Position',[dx1+.17 y6+.095 .03 .025],'String','>','BackgroundColor',[.7 .7 .8],'HorizontalAlignment','center','Callback','edits_cb(7)');
leda2.gui.eventinfo.txtlab_name  = uicontrol('Units','normalized','Style','text','Position',[dx2 y6+.06 .1 .02],'String','Name:','BackgroundColor',leda2.gui.col.frame1,'HorizontalAlignment','left');
leda2.gui.eventinfo.txtlab_time  = uicontrol('Units','normalized','Style','text','Position',[dx2 y6+.04 .1 .02],'String','Time:','BackgroundColor',leda2.gui.col.frame1,'HorizontalAlignment','left');
leda2.gui.eventinfo.txtlab_niduserdata  = uicontrol('Units','normalized','Style','text','Position',[dx2 y6+.02 .1 .02],'String','Nid & Userdata:','BackgroundColor',leda2.gui.col.frame1,'HorizontalAlignment','left');

leda2.gui.eventinfo.edit_eventnr  = uicontrol('Units','normalized','Style','edit','Position',[dx1+.13 y6+.095 .04 .025],'String','','HorizontalAlignment','center','Callback','edits_cb(5)'); %,'BackgroundColor',leda2.gui.col.frame1
leda2.gui.eventinfo.txt_name  = uicontrol('Units','normalized','Style','text','Position',[dx3 y6+.06 .1 .02],'String','','BackgroundColor',leda2.gui.col.frame1,'HorizontalAlignment','left');
leda2.gui.eventinfo.txt_time  = uicontrol('Units','normalized','Style','text','Position',[dx3 y6+.04 .1 .02],'String','','BackgroundColor',leda2.gui.col.frame1,'HorizontalAlignment','left');
leda2.gui.eventinfo.txt_niduserdata  = uicontrol('Units','normalized','Style','text','Position',[dx3 y6+.02 .1 .02],'String','','BackgroundColor',leda2.gui.col.frame1,'HorizontalAlignment','left');

%Session History Display
leda2.gui.infobox = uicontrol('Units','normalized','Style','listbox','Position',[x3 y8 x4-x3 y7-y8],'Max',2,'String','','HorizontalAlignment','left','FontSize',7);
