-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020



/*
drop database link db2_dblink;
create database link db2_dblink
  connect to CG_PROY_ADMIN identified by samjor
  using '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com)(PORT=1521))(CONNECT_DATA=(SID=SCOOTERS)))';

exec rdsadmin.rdsadmin_util.create_directory('TABLA_EXTERNA');
create directory TABLA_EXTERNA as 'TABLA_EXTERNA';

declare
  lfh utl_file.file_type;
  rfh utl_file.file_type@db2_dblink;
  ldata raw(32767);
begin
  lfh := utl_file.fopen(location=>'PROYECTO', filename=>'ZONA_TABLA.csv', open_mode=>'rb');
  rfh := utl_file.fopen@db2_dblink(location=>'TABLA_EXTERNA', filename=>'ZONA_TABLA.csv', open_mode=>'wb');
  begin
    loop
      begin
        utl_file.get_raw(lfh, ldata, 32767);
        utl_file.put_raw@db2_dblink(rfh, ldata, true);
      exception
        when no_data_found then
          exit;
      end;
    end loop;
  end;
  utl_file.fclose(lfh);
  utl_file.fclose@db2_dblink(rfh);  
exception 
  when others then
    utl_file.fclose(lfh);
    utl_file.fclose@db2_dblink(rfh);
    raise;
end;
*/ 
DECLARE
 file_exists NUMBER := 0;
BEGIN
  file_exists := DBMS_LOB.FILEEXISTS(BFILENAME('TABEXT','.'));
  IF ( file_exists = 1 ) THEN
    EXECUTE IMMEDIATE 'DROP DIRECTORY TABEXT';
  ELSE
    NULL;
  END IF;
END;
/
exec rdsadmin.rdsadmin_util.create_directory('TABEXT');
DECLARE
  lfh utl_file.file_type;
begin
  lfh := utl_file.fopen(location=>'TABEXT', filename=>'texto.txt', open_mode=>'w');
  utl_file.put_line(lfh, 'ZONA_ID,NOMBRE,POLIGONO');
  utl_file.put_line(lfh, '1,Tlalpan,&-99.1967110331436#19.302404970018400 &-99.17928754530040#19.303440355691000&-99.16285464074420#19.301372491551300&-99.15666453594390#19.296836836709400&-99.15162094979960#19.298006420739200&-99.1474100816765#19.301286410450900&-99.14261623525290#19.299606363162300&-99.1347247282744#19.308293978512400&-99.11680778027510#19.301420243457100&-99.10920741083380#19.29961826313350&-99.10092916684800#19.300021049950700&-99.10136374174250#19.29520005862510&-99.10502204439370#19.293517132085300&-99.12492521522400#19.285241176214900&-99.13510705120180#19.282461436280300&-99.1410559541496#19.282528593430500&-99.14118814406970#19.27353455005050&-99.14492144041680#19.26744682514280');
  utl_file.put_line(lfh, '2,Xochimilco,&-99.13301433831460#19.210095007036300&-99.13831586910340#19.215728240793&-99.15439486389090#19.220639277190000&-99.15351936519450#19.2218062433421&-99.15248051991660#19.220533831979500&-99.15115021097920#19.223407971054000&-99.15337849450630#19.225981822613500&-99.15068317551890#19.234688869889900&-99.14946506184100#19.23403188292160&-99.14823412722840#19.236308462179200&-99.14787673661580#19.234557250756800&-99.14445253539010#19.234524853641300&-99.14751983532020#19.24025920850860&-99.1440114871711#19.239684485878500&-99.14425539777830#19.244740262602100&-99.14038408380780#19.243594717861000&-99.13892150427620#19.245966329518100&-99.14172562521060#19.248995202168800');
  utl_file.put_line(lfh, '3,La Magdalena Contreras,&-99.2448874107016#19.276209415701700&-99.24345877301270#19.275649195688100&-99.24461320886800#19.272902328111400&-99.2434678285231#19.26978988324660&-99.24699686412070#19.265595475193100&-99.24552836079710#19.262933138739900&-99.24723653608300#19.260277316856300&-99.24388825030400#19.25920067422710&-99.2453858237599#19.257342102788000&-99.24458507740080#19.25273263167940&-99.24800769441110#19.246733750051500&-99.25035096337670#19.24569327622870&-99.25290911481860#19.235467427827800&-99.27067823460690#19.22420301366990&-99.27415659698290#19.221038896546300&-99.27420672504400#19.218152400718100&-99.27734058432510#19.214716005752300&-99.2823935774748#19.213081460472000');
  utl_file.put_line(lfh, '4,Azcapotzalco,&-99.15718110621090#19.50284888316680&-99.1431181269405#19.46506268586540&-99.15055405158390#19.462940418629300&-99.15865070110010#19.463924958549800&-99.16371277378950#19.456434775836200&-99.1884832426999#19.460777255335500&-99.18800022814290#19.463814624542800&-99.19073111446590#19.464671440429100&-99.19095586108650#19.4706294695539&-99.20101501747750#19.473359606412200&-99.20682497656240#19.471215070586000&-99.22111507087190#19.475068475187900&-99.21016416350510#19.511139123934900&-99.20467164604260#19.515135960620200&-99.18229080647350#19.50746979832630&-99.17705041680580#19.506194905334500&-99.17304284081710#19.50858670433900&-99.15718110621090#19.50284888316680');
  utl_file.put_line(lfh, '5,Benito Juarez,&-99.14349968483090#19.35724145471900&-99.16978033508190#19.35865953668290&-99.17774193260510#19.365141458616800&-99.18371203722190#19.36171806767010&-99.19109309984510#19.363489747907700&-99.19173374696430#19.38268083218240&-99.18841323489130#19.39323015177560&-99.18905517469270#19.395590329764600&-99.15632922300870#19.40406328178320&-99.13740614837830#19.40346354556430&-99.13718232835710#19.399200322259800&-99.13094248661120#19.39895431711120&-99.13983599361720#19.35691760404170&-99.14349968483090#19.35724145471900');
  utl_file.put_line(lfh, '6,Cuauhtemoc,&-99.17438756110090#19.40452145491210&-99.18430391561480#19.407826989726200&-99.17505501892670#19.42304279488950&-99.17763620602990#19.423595700743900&-99.16578098215800#19.443648678271400&-99.16315414834060#19.45888347900390&-99.15954891164230#19.46332446186430&-99.15031399513950#19.462960119995900&-99.14174041633080#19.46581594560160&-99.13333667349800#19.46485416850970&-99.12224120790020#19.459782400756600&-99.12588902892010#19.448186958111800&-99.12307881194720#19.4424954406602&-99.12819972562540#19.41375994061430&-99.12569845710020#19.404330675650900&-99.13644192460580#19.4028106408329&-99.15632922300870#19.40406328178320&-99.17043552819570#19.3997898043978');
  utl_file.put_line(lfh, '7,Alvaro Obregon,&-99.18905517469270#19.395590329764600&-99.18841323489130#19.39323015177560&-99.19173374696430#19.38268083218240&-99.19109309984510#19.363489747907700&-99.18371203722190#19.36171806767010&-99.17774193260510#19.365141458616800&-99.17170610834040#19.359568262520300&-99.18055473745960#19.347235783838700&-99.18287487305550#19.34658431395830&-99.18403835252570#19.343647986116000&-99.19123595100640#19.336876994649100&-99.19805680075050#19.335484149937000&-99.19982092549560#19.333505378267900&-99.1962946995587#19.33363128500700&-99.19470419431130#19.330233498451800&-99.19498778680200#19.32184251328190&-99.20118465292220#19.311953545432900&-99.2002471268194#19.311160030938300');
  utl_file.put_line(lfh, '8,Gustavo A. Madero,&-99.1178878465872#19.590592301354100&-99.11859756186690#19.584461728001900&-99.11466172266090#19.579796309292200&-99.1118180486024#19.56872692194690&-99.10809721552020#19.564888494978000&-99.13057458998830#19.536091294999200&-99.12736766622460#19.535083906579600&-99.12800459133120#19.52453111808900&-99.11440711155970#19.511060815011300&-99.1076355159634#19.511026560677200&-99.10730429311530#19.509684994035500&-99.09739953068160#19.512631244481400&-99.06386253396490#19.49877871444570&-99.06799134225580#19.48908321073260&-99.0648528988523#19.481835964947700&-99.06327781749120#19.48126764712470&-99.06336101019340#19.478609278231000&-99.0508684205664#19.45018101237530');
  utl_file.put_line(lfh, '9,Cuajimalpa de Morelos,&-99.25737566128120#19.401120224052300&-99.25580791104170#19.40357241875500&-99.2556835548959#19.397262706292100&-99.25962640457690#19.3943130084646&-99.25925152237270#19.392599375362500&-99.25483968066550#19.39370739391850&-99.25475424233510#19.39521675636210&-99.25255668051590#19.393524875306500&-99.24703579178660#19.394181906857000&-99.24852709773870#19.390409364282500&-99.24765261379960#19.385957016160100&-99.26135349187670#19.37584065457450&-99.27016100966470#19.372629131625700&-99.26837995216590#19.37180883621690&-99.26843379338480#19.368713167184100&-99.26507495035190#19.371745640627900&-99.26683311458610#19.363545277221600&-99.26125984357980#19.361044402689900');
  utl_file.put_line(lfh, '10,Miguel Hidalgo,&-99.16371277378950#19.456434775836200&-99.16578098215800#19.443648678271400&-99.17763620602990#19.423595700743900&-99.17505501892670#19.42304279488950&-99.18430391561480#19.407826989726200&-99.17107853777470#19.403497168994100&-99.17043552819570#19.3997898043978&-99.18905517469270#19.395590329764600&-99.19220139449920#19.40374302705540&-99.19761364797040#19.40309120075650&-99.22357876430860#19.395852712521400&-99.23784260601910#19.393491268485200&-99.23992904743510#19.388864064341300&-99.24765261379960#19.385957016160100&-99.24852709773870#19.390409364282500&-99.24703579178660#19.394181906857000&-99.25255668051590#19.393524875306500&-99.25475424233510#19.39521675636210');
  utl_file.put_line(lfh, '11,Iztacalco,&-99.05578648867040#19.422141081466900&-99.06084839747310#19.382588320819300&-99.06636556793850#19.38353710380730&-99.08401799062980#19.39257215598430&-99.08458373889630#19.389475278287700&-99.08880137003410#19.39038230914200&-99.0956476434717#19.379598877409800&-99.12247651535430#19.382440689617300&-99.1225339203193#19.375699513915000&-99.13548772203740#19.377186991573500&-99.13094248661120#19.39895431711120&-99.13718232835710#19.399200322259800&-99.13658765265530#19.40281181257920&-99.0980434248615#19.409137834227700&-99.07824041431460#19.407050277176600&-99.06949545640500#19.42025280045310&-99.05578648867040#19.422141081466900');
  utl_file.put_line(lfh, '12,Coyoacan,&-99.18078642228380#19.347143511050400&-99.17170610834040#19.359568262520300&-99.13427049856510#19.356540688329000&-99.13117791343190#19.35866085405940&-99.12197974597880#19.3576619228576&-99.12077736876520#19.35184147099840&-99.11557154154900#19.343264128378900&-99.11293458518990#19.335368498349400&-99.10572932511420#19.326300338579200&-99.09920703472980#19.320917013189600&-99.10092916684800#19.300021049950700&-99.10920741083380#19.29961826313350&-99.11680778027510#19.301420243457100&-99.1347247282744#19.308293978512400&-99.14261623525290#19.299606363162300&-99.1474100816765#19.301286410450900&-99.15162094979960#19.298006420739200&-99.15666453594390#19.296836836709400');
  utl_file.put_line(lfh, '13,Venustiano Carranza,&-99.11690472348630#19.45782834150510&-99.11177513017070#19.453781279430000&-99.10136629802500#19.4499424036943&-99.09321980174050#19.45160023080010&-99.08715634090130#19.445766861831&-99.08087674939270#19.450157317722000&-99.06228517828360#19.444790515935000&-99.0508684205664#19.45018101237530&-99.04645882385200#19.442364636987800&-99.05578648867040#19.422141081466900&-99.06949545640500#19.42025280045310&-99.07797853699070#19.407147577265000&-99.09796675030650#19.409142917215500&-99.12569845710020#19.404330675650900&-99.12819972562540#19.41375994061430&-99.12307881194720#19.4424954406602&-99.12588902892010#19.448186958111800&-99.12224120790020#19.459782400756600');
  utl_file.put_line(lfh, '14,Tlahuac,&-98.97892779105560#19.323930545495000&-98.97820309492110#19.325331083217000&-98.97651651474330#19.324255686147500&-98.97532368335060#19.325643496735600&-98.9663519245887#19.325671742539500&-98.96044824331300#19.32537215247090&-98.95790262286990#19.323227615942100&-98.9629658232194#19.31672738897740&-98.96477606323640#19.30688076979640&-98.96722384490910#19.30596983962440&-98.97653062569530#19.253125388859000&-98.96598686988070#19.249941007153900&-98.96858650405380#19.23221794814090&-98.940302812056#19.22323964027380&-98.9425532108355#19.215614861396300&-98.95108553483500#19.21818369998650&-98.95394833335090#19.214645847222100&-98.96269404913760#19.2141426287901');
  utl_file.put_line(lfh, '15,Iztapalapa,&-99.0581328804774#19.40071958054630&-99.01957204918620#19.383256349789600&-98.99193917967470#19.367598706408000&-98.99455666701410#19.3581413255309&-98.97879332077070#19.34328927915270&-98.97432515234540#19.337026570049300&-98.96044824331300#19.32537215247090&-98.97532368335060#19.325643496735600&-98.97651651474330#19.324255686147500&-98.97820309492110#19.325331083217000&-98.97856031324470#19.32390249832140&-98.98060733492060#19.32465664568780&-98.97986822899980#19.326139582424700&-99.00135430613720#19.327133629183800&-99.04044249154200#19.31541473554760&-99.04361252036370#19.312207740874000&-99.0466177319435#19.314876489248600&-99.04885511904160#19.3118876558084');
  utl_file.put_line(lfh, '16,Milpa Alta,&-98.99717700329620#19.227472571515600&-98.9957908732171#19.225038496347300&-98.99526391162220#19.227514914777900&-98.9937254154806#19.227470456824100&-98.9932627822685#19.224944851833700&-98.99055868468120#19.225778349342700&-98.97815003517600#19.21506830842480&-98.973621405256#19.21408292697080&-98.96683776422840#19.20900655817050&-98.96722874207890#19.20625109428660&-98.96967857342840#19.204252913535400&-98.96770189151830#19.203128841053800&-98.96702583222890#19.199909853940000&-98.96769389228350#19.189743078896000&-98.95984905760780#19.17916787678870&-98.95617468287960#19.176763062936800&-98.95238564842700#19.168637616145500&-98.9673663980567#19.164438689165800');
  utl_file.fclose(lfh);
end;
/ 

CREATE TABLE ZONA_EXERNA(
  ZONA_ID     NUMBER(10,0),
  NOMBRE      VARCHAR2(40),
  POLIGONO    VARCHAR2(4000)  
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY TABEXT
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ','
  )
  LOCATION ('texto.txt')
)
PARALLEL
REJECT LIMIT UNLIMITED;

CREATE TABLE ZONA AS SELECT * FROM ZONA_EXERNA;

ALTER TABLE ZONA ADD CONSTRAINT ZONA_PK PRIMARY KEY (ZONA_ID);
ALTER TABLE ZONA ADD CONSTRAINT ZONA_POLIGONO_UK UNIQUE(POLIGONO);
ALTER TABLE ZONA_SCOOTER ADD CONSTRAINT ZONA_SCOOTER_ZONA_ID_FK FOREIGN KEY (ZONA_ID) REFERENCES ZONA(ZONA_ID);
ALTER TABLE ZONA_SCOOTER ADD CONSTRAINT ZONA_SCOOTER_PK PRIMARY KEY (ZONA_ID, SCOOTER_ID);

whenever sqlerror continue;

