-- CREACIÓN DE TABLAS

CREATE TABLE CILINDROS  (	
OIDCILINDRO NUMBER NOT NULL, 
CODIGOCILINDRO VARCHAR2(20 BYTE) NOT NULL, 
ESTADOCILINDRO VARCHAR2(20 BYTE) NOT NULL, 
FECHAESTADOCILINDRO DATE, 
MOTIVOESTADOCILINDRO VARCHAR2(20 BYTE), 
CONSTRAINT CILINDROS_CHK1 CHECK (ESTADOCILINDRO IN('OPERATIVO' ,'DEFECTUOSO')) ENABLE, 
	CONSTRAINT CILINDROS_PK PRIMARY KEY (OIDCILINDRO) ENABLE
);


CREATE TABLE PLATOS (
OIDPLATO NUMBER NOT NULL, 
CODIGOPLATO VARCHAR2(20 BYTE) NOT NULL, 
ESTADOPLATO VARCHAR2(20 BYTE) NOT NULL, 
FECHAESTADOPLATO DATE, 
	MOTIVOESTADOPLATO VARCHAR2(20 BYTE), 
CONSTRAINT PLATOS_CHK1 CHECK (ESTADOPLATO IN('OPERATIVO' ,'DEFECTUOSO')) ENABLE, 
	 CONSTRAINT PLATOS_PK PRIMARY KEY (OIDPLATO) ENABLE
);

CREATE TABLE MESAS (	
OIDMESA NUMBER NOT NULL, 
	NOMBREMESA VARCHAR2(20 BYTE) NOT NULL, 
CONSTRAINT MESAS_PK PRIMARY KEY (OIDMESA) ENABLE
);

CREATE TABLE EMPLEADOS (	
OIDEMPLEADO NUMBER NOT NULL, 
	CODIGOEMPLEADO VARCHAR2(20 BYTE) NOT NULL, 
	NOMBREEMPLEADO VARCHAR2(100 BYTE) NOT NULL, 
	CONSTRAINT EMPLEADOS_PK PRIMARY KEY (OIDEMPLEADO) ENABLE
);

CREATE TABLE JUGADORES (	
OIDJUGADOR NUMBER NOT NULL, 
	CODIGOJUGADOR VARCHAR2(20 BYTE) NOT NULL, 
	NOMBREJUGADOR VARCHAR2(100 BYTE) NOT NULL, 
CONSTRAINT JUGADORES_PK PRIMARY KEY (OIDJUGADOR) ENABLE
);

CREATE TABLE PAYMENTS  (	
OIDPAYMENT NUMBER NOT NULL, 
	IMPORTEPAYMENT NUMBER NOT NULL, 
	FECHAYHORAPAYMENT DATE NOT NULL, 
	OIDJUGADOR NUMBER NOT NULL, 
	CONSTRAINT PAYMENTS_PK PRIMARY KEY (OIDPAYMENT) ENABLE
);

CREATE TABLE RULETAS (	
OIDRULETA NUMBER NOT NULL, 
	NOMBRERULETA VARCHAR2(20 BYTE) NOT NULL, 
	OIDCILINDRO NUMBER NOT NULL, 
	OIDPLATO NUMBER NOT NULL, 
	CONSTRAINT RULETAS_PK PRIMARY KEY (OIDRULETA) ENABLE
);

CREATE TABLE CONFIGURACIONES (	
OIDCONFIGURACION NUMBER NOT NULL, 
	FECHAYHORAINICIO DATE NOT NULL, 
	FECHAYHORAFIN DATE NOT NULL, 
	OIDEMPLEADOCRUPIER NUMBER NOT NULL, 
	OIDEMPLEADOJEFEMESA NUMBER NOT NULL, 
	OIDMESA NUMBER NOT NULL, 
	OIDRULETA NUMBER NOT NULL, 
CONSTRAINT EMPLEADOS_CHK1 CHECK (OIDEMPLEADOCRUPIER!= OIDEMPLEADOJEFEMESA) ENABLE, 
CONSTRAINT FECHAYHORA_CHK1 CHECK (FECHAYHORAINICIO<FECHAYHORAFIN) ENABLE, 
CONSTRAINT CONFIGURACIONES_PK PRIMARY KEY (OIDCONFIGURACION) ENABLE
);

CREATE TABLE TIRADAS (	
OIDTIRADA NUMBER NOT NULL, 
	CODIGOTIRADA VARCHAR2(20 BYTE) NOT NULL, 
	NUMEROGANADOR NUMBER NOT NULL, 
	FECHAYHORATIRADA DATE NOT NULL, 
	VELOCIDADPLATO NUMBER NOT NULL, 
	SENTIDOGIROBOLA VARCHAR2(20 BYTE) NOT NULL, 
	OIDCONFIGURACION NUMBER NOT NULL, 
CONSTRAINT TIRADAS_NGANADOR_CHK1 CHECK (NUMEROGANADOR BETWEEN 0 AND 36) ENABLE, 
CONSTRAINT TIRADAS_CHK1 CHECK (SENTIDOGIROBOLA IN ('CLOCKWISE','ANTICLOCKWISE')) ENABLE, 
	 CONSTRAINT TIRADAS_PK PRIMARY KEY (OIDTIRADA) ENABLE
);

CREATE TABLE WINS (	
OIDWIN NUMBER NOT NULL, 
	IMPORTEWIN NUMBER NOT NULL, 
	FECHAYHORAWIN DATE NOT NULL, 
	OIDCONFIGURACION NUMBER NOT NULL, 
	OIDJUGADOR NUMBER NOT NULL, 
	CONSTRAINT WINS_PK PRIMARY KEY (OIDWIN) ENABLE
);
  
CREATE TABLE DROPS  (	
OIDDROP NUMBER NOT NULL, 
	IMPORTEDROP NUMBER NOT NULL, 
	FECHAYHORADROP DATE NOT NULL, 
	OIDCONFIGURACION NUMBER NOT NULL, 
	OIDJUGADOR NUMBER NOT NULL, 
	 CONSTRAINT DROPS_PK PRIMARY KEY (OIDDROP) ENABLE
);
  
CREATE TABLE RESULTADOSTIRADAS (
	OIDRESTIRADA NUMBER NOT NULL, 
	CANTIDADGANADA NUMBER NOT NULL, 
	CANTIDADAPOSTADA NUMBER NOT NULL, 
	OIDJUGADOR NUMBER NOT NULL, 
	OIDTIRADA NUMBER NOT NULL, 
CONSTRAINT RESULTADOSTIRADAS_PK PRIMARY KEY (OIDRESTIRADA) ENABLE
);


-- Creación de foreign keys.

ALTER TABLE PAYMENTS ADD CONSTRAINT OIDJUGADORPAY_FK FOREIGN KEY (OIDJUGADOR) REFERENCES JUGADORES (OIDJUGADOR) ENABLE;

ALTER TABLE RULETAS ADD CONSTRAINT OIDCILINDRO_FK FOREIGN KEY (OIDCILINDRO) REFERENCES CILINDROS (OIDCILINDRO) ENABLE;

ALTER TABLE RULETAS ADD CONSTRAINT OIDPLATO_FK FOREIGN KEY (OIDPLATO) REFERENCES PLATOS (OIDPLATO) ENABLE;

ALTER TABLE CONFIGURACIONES ADD CONSTRAINT OIDEMPLEADOCRUPIER_FK FOREIGN KEY (OIDEMPLEADOCRUPIER) REFERENCES EMPLEADOS (OIDEMPLEADO) ENABLE;

ALTER TABLE CONFIGURACIONES ADD CONSTRAINT OIDEMPLEADOJEFEMESA_FK FOREIGN KEY (OIDEMPLEADOJEFEMESA) REFERENCES EMPLEADOS (OIDEMPLEADO) ENABLE;

ALTER TABLE CONFIGURACIONES ADD CONSTRAINT OIDMESA_FK FOREIGN KEY (OIDMESA) REFERENCES MESAS (OIDMESA) ENABLE;

ALTER TABLE CONFIGURACIONES ADD CONSTRAINT OIDRULETAS_FK FOREIGN KEY (OIDRULETA) REFERENCES RULETAS (OIDRULETA) ENABLE;

ALTER TABLE TIRADAS ADD CONSTRAINT OIDCONFIGURACIONTIRADAS FOREIGN KEY (OIDCONFIGURACION) REFERENCES CONFIGURACIONES (OIDCONFIGURACION) ENABLE;

ALTER TABLE WINS ADD CONSTRAINT OIDCONFIGURACIONWIN_FK FOREIGN KEY (OIDCONFIGURACION) REFERENCES CONFIGURACIONES (OIDCONFIGURACION) ENABLE;

ALTER TABLE WINS ADD CONSTRAINT OIDJUGADORWIN_FK FOREIGN KEY (OIDJUGADOR) REFERENCES JUGADORES (OIDJUGADOR) ENABLE;

ALTER TABLE DROPS ADD CONSTRAINT OIDCONFIGURACIONDROPS_FK FOREIGN KEY (OIDCONFIGURACION) REFERENCES CONFIGURACIONES (OIDCONFIGURACION) ENABLE;

ALTER TABLE DROPS ADD CONSTRAINT OIDJUGADORDROPS_FK FOREIGN KEY (OIDJUGADOR) REFERENCES JUGADORES (OIDJUGADOR) ENABLE; 

ALTER TABLE RESULTADOSTIRADAS	ADD CONSTRAINT OIDJUGADORRESTI_FK FOREIGN KEY (OIDJUGADOR) REFERENCES JUGADORES (OIDJUGADOR) ENABLE;

ALTER TABLE RESULTADOSTIRADAS ADD CONSTRAINT OIDTIRADARESTI_FK FOREIGN KEY (OIDTIRADA) REFERENCES TIRADAS (OIDTIRADA) ENABLE;

-- creación de secuencias 

CREATE SEQUENCE  SEQUENCECILINDRO  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCEPLATO  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCEMESA  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCEEMPLEADO  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

   CREATE SEQUENCE  SEQUENCEJUGADOR  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCEPAYMENT  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCERULETA  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCECONFIGURACION  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCETIRADA  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCEWIN  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCEDROP  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

CREATE SEQUENCE  SEQUENCERESULTADOTIRADA  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 ;

--  CREACIÓN DE FUNCIONES

create or replace FUNCTION BUSCARULETA (
w_cilindro varchar2, 
w_plato varchar2
) RETURN NUMBER AS
w_oidruleta number;
w_oidcilindro number;
w_oidplato number;
w_nombreruleta varchar2(20);

BEGIN
select oidruleta into w_oidruleta from ruletas, platos, cilindros where codigoplato = w_plato AND codigocilindro = w_cilindro AND ruletas.oidcilindro = cilindros.oidcilindro AND ruletas.oidplato = platos.oidplato;

return w_oidruleta;

exception when no_data_found then
select oidcilindro into w_oidcilindro from cilindros where codigocilindro = w_cilindro;

select oidplato into w_oidplato from platos where codigoplato = w_plato;
w_nombreruleta := 'RULETA - ' || to_char(w_oidcilindro) || '-' || to_char(w_oidplato);
w_oidruleta := sequenceruleta.nextval;

INSERT INTO ruletas (oidruleta, nombreruleta, oidcilindro, oidplato) VALUES (w_oidruleta, w_nombreruleta, w_oidcilindro, w_oidplato);
   
RETURN w_oidruleta;

END BUSCARULETA;

/

create or replace FUNCTION  CONFIGURACION_MESA_FECHA (
W_MESA IN MESAS.NOMBREMESA%TYPE, 
W_FECHA IN VARCHAR2
) RETURN NUMBER IS 
W_OIDCONF CONFIGURACIONES.OIDCONFIGURACION%TYPE; 
W_FECHAAUX  DATE; 

BEGIN 
W_FECHAAUX:=TO_DATE(W_FECHA, 'DD-MM-YYYY HH24:MI:SS'); 

SELECT OIDCONFIGURACION INTO W_OIDCONF FROM CONFIGURACIONES, MESAS WHERE  W_MESA = MESAS.NOMBREMESA AND MESAS.OIDMESA = CONFIGURACIONES.OIDMESA AND W_FECHAAUX  BETWEEN CONFIGURACIONES.FECHAYHORAINICIO AND CONFIGURACIONES.FECHAYHORAFIN; 
RETURN W_OIDCONF;

EXCEPTION WHEN NO_DATA_FOUND THEN 
W_OIDCONF:=0;

RETURN W_OIDCONF;

END CONFIGURACION_MESA_FECHA;

/

create or replace FUNCTION SESIONINICIO (
w_fecha IN date
) RETURN DATE IS 
w_fechayhora DATE;

BEGIN

w_fechayhora := (w_fecha + INTERVAL '7' HOUR);
--dbms_output.put_line(w_fechayhora);

RETURN w_fechayhora;

END sesionInicio;

/

create or replace FUNCTION SESIONFIN (
w_fecha IN DATE
) RETURN DATE IS 
w_fechayhora DATE;

BEGIN
w_fechayhora := w_fecha + INTERVAL '1' DAY - INTERVAL '1' SECOND + INTERVAL '7' HOUR;
--dbms_output.put_line(w_fechayhora);

RETURN w_fechayhora;

END sesionfin;

/

create or replace FUNCTION NUMEROMEDIOTIRADAS (
w_crupier IN empleados.codigoempleado%TYPE, 
w_fechai IN VARCHAR2, 
w_fechaf IN VARCHAR2
) RETURN NUMBER IS
w_media number;
w_minutos number; 
w_count1 number; 
w_count2 number;
w_max DATE; 
w_min DATE; 
w_oidconfi number;
w_minutosaux number;
w_fechaisesion DATE;
w_fechafsesion DATE;

--Declaración del cursor
CURSOR cursor_crupier IS  
SELECT configuraciones.oidconfiguracion 
FROM configuraciones, empleados
WHERE empleados.codigoempleado = w_crupier AND configuraciones.fechayhorainicio <= W_fechaf 
AND configuraciones.fechayhorafin >= w_fechai AND empleados.oidempleado = configuraciones.oidempleadocrupier;
 
BEGIN 

w_fechaisesion := sesioninicio(to_date(w_fechai, 'DD/MM/YYYY'));
w_fechafsesion := sesionfin(to_date(w_fechaf, 'DD/MM/YYYY'));
w_count2:=0;
w_minutos:=0;
w_minutosaux:=0;

OPEN cursor_crupier; 
LOOP 
FETCH cursor_crupier INTO w_oidconfi; 
 EXIT WHEN cursor_crupier%NOTFOUND;
selecT Count(*),Max(TIRADAS.FECHAYHORATIRADA),MIN(TIRADAS.FECHAYHORATIRADA)into w_count1, w_max, w_min from tiradas where tiradas.oidconfiguracion = w_oidconfi and tiradas.fechayhoratirada between w_fechaisesion and w_fechafsesion; 
  	IF w_count1>0 THEN
w_count2:=w_count1+w_count2;
w_minutos:=w_minutos+((w_max-w_min)*1440);
END IF;  
END LOOP; 
CLOSE cursor_crupier; 

if w_minutos = 0 THEN 
w_media := 0;
ELSE
w_media:=w_count2/w_minutos;
END IF;

RETURN w_media;

END numeroMedioTiradas;

/

create or replace FUNCTION RENDIMIENTO (
w_crupier IN empleados.codigoempleado%TYPE, 
w_fechai IN varchar2, 
w_fechaf IN varchar2
) RETURN VARCHAR2 IS
w_media number; 
w_minutos number; 
w_count1 number ; 
w_count2 number;
w_max date; 
w_min date; 
w_oidconfi number;
w_aux number;
w_res VARCHAR2(150);
w_fechaisesion DATE;
w_fechafsesion DATE;
w_mediachar varchar2(20);
w_auxchar varchar2(20);

--Declaración del cursor
CURSOR cursor_rendimiento IS 
SELECT  configuraciones.oidconfiguracion 
FROM configuraciones
WHERE configuraciones.fechayhorainicio<=W_fechaf 
AND configuraciones.fechayhorafin>=w_fechai;

BEGIN 
w_fechaisesion := sesioninicio(to_date(w_fechai, 'DD/MM/YYYY'));
w_fechafsesion := sesionfin(to_date(w_fechaf, 'DD/MM/YYYY'));
w_count2 := 0;
w_minutos := 0;

OPEN cursor_rendimiento;
LOOP 
FETCH cursor_rendimiento INTO w_oidconfi; 
EXIT WHEN cursor_rendimiento%NOTFOUND;
select count(*), max(TIRADAS.FECHAYHORATIRADA),MIN(TIRADAS.FECHAYHORATIRADA)into w_count1, w_max, w_min from tiradas where tiradas.oidconfiguracion = w_oidconfi and tiradas.fechayhoratirada between w_fechaisesion and w_fechafsesion; 

IF w_count1>0 THEN
w_count2:=w_count1+w_count2;
w_minutos:=w_minutos+((w_max-w_min)*1440);
--  dbms_output.put_line(w_oidconfi || ' - ' || w_count1 || ' - ' || w_minutos);
END IF; 
END LOOP; 

CLOSE cursor_rendimiento; 

w_media:=w_count2/w_minutos;
w_mediachar := to_char(w_media,'0.000');

w_aux := numeromediotiradas(w_crupier, w_fechai, w_fechaf);
w_auxchar := to_char(w_aux,'0.000');

IF w_aux = 0 THEN
w_res := ' no ha trabajado en las fechas solicitadas';
ELSE IF w_aux > w_media THEN 
w_res:= ' está por encima de la media. Su rendimiento es: ' ||
w_auxchar || ' y la media es: ' || w_mediachar || '
(tiradas/minuto)';
ELSE IF w_aux < w_media THEN 
w_res:= ' está por debajo de la media. Su rendimiento es: ' || w_auxchar || ' y la media es: ' || w_mediachar || ' (tiradas/minuto)';
ELSE 
w_res:= 'esta en el rendimiento medio. Su rendimiento es: ' || w_auxchar || ' y la media es: ' || w_mediachar || ' (tiradas/minuto)';
END IF;
END IF;
END IF;

RETURN w_res;

END rendimiento;

/

-- CREACIÓN DE PROCEDIMIENTOS

create or replace PROCEDURE INSERTARCILINDROS (
w_cod in cilindros.codigocilindro%type, 
w_estado in cilindros.estadocilindro%type,
w_fechachar in varchar2, 
w_motivo in cilindros.motivoestadocilindro%type
) AS

w_fecha DATE;

BEGIN 
w_fecha := to_date(w_fechachar,'DD/MM/YYYY');

INSERT INTO cilindros (cilindros.oidcilindro, codigocilindro, estadocilindro, fechaestadocilindro, motivoestadocilindro) VALUES (sequencecilindro.nextval, w_cod, w_estado, w_fecha, w_motivo);

END INSERTARCILINDROS;

/

create or replace PROCEDURE INSERTARPLATOS (
w_cod in platos.codigoplato%type, 
w_estado in platos.estadoplato%type, 
w_fechachar in varchar2, 
w_motivo in platos.motivoestadoplato%type
) AS

w_fecha DATE;

BEGIN 
w_fecha := to_date(w_fechachar,'DD/MM/YYYY');

INSERT INTO platos (platos.oidplato, codigoplato, estadoplato, fechaestadoplato, motivoestadoplato) VALUES (sequenceplato.nextval, w_cod, w_estado, w_fecha, w_motivo);

END INSERTARPLATOS;

/

create or replace PROCEDURE INSERTARMESAS (
w_mesa in mesas.nombremesa%type
) AS

BEGIN 

INSERT INTO mesas (mesas.oidmesa, nombremesa) VALUES (sequencemesa.nextval, w_mesa);

END INSERTARMESAS;

/

create or replace PROCEDURE INSERTAREMPLEADOS (
w_cod in empleados.codigoempleado%type, 
w_nombre in empleados.nombreempleado%type
) AS

BEGIN 

INSERT INTO empleados (empleados.oidempleado, codigoempleado, nombreempleado) VALUES (sequenceempleado.nextval, w_cod, w_nombre);

END INSERTAREMPLEADOS;

/

create or replace PROCEDURE INSERTARJUGADORES (
w_cod in jugadores.codigojugador%type, 
w_nombre in jugadores.nombrejugador%type
) AS

BEGIN 

INSERT INTO jugadores (jugadores.oidjugador, codigojugador, nombrejugador) VALUES (sequencejugador.nextval, w_cod, w_nombre);

END INSERTARJUGADORES;


/

create or replace PROCEDURE INSERTARPAYMENTS (
w_jugador IN JUGADORES.CODIGOJUGADOR%TYPE,
w_fechayhorapagochar IN VARCHAR2, 
w_pago IN PAYMENTS.IMPORTEPAYMENT%TYPE
) IS
w_fecha DATE; 
W_OIDJUGADOR NUMBER;

BEGIN
w_fecha := to_date(w_fechayhorapagochar, 'DD/MM/YYYY HH24:MI:SS');

SELECT OIDJUGADOR INTO W_OIDJUGADOR FROM JUGADORES WHERE CODIGOJUGADOR =  W_JUGADOR;

INSERT INTO payments (oidpayment, importepayment,fechayhorapayment,OIDJUGADOR) VALUES (sequencepayment.nextval, w_pago, w_fecha,W_OIDJUGADOR);

END insertarpaymentS;

/

create or replace PROCEDURE INSERTARRULETAS (
w_codcilindro in cilindros.codigocilindro%type, w_codplato in platos.codigoplato%type
) AS
w_nomruleta VARCHAR2(50);
w_oidcil NUMBER;
w_oidplat NUMBER;

BEGIN

SELECT oidcilindro INTO w_oidcil FROM cilindros WHERE codigocilindro = w_codcilindro;

SELECT oidplato INTO w_oidplat FROM platos WHERE codigoplato = w_codplato;

w_nomruleta := 'RULETA - ' || to_char(w_oidcil) || '-' || to_char(w_oidplat);

INSERT INTO ruletas (oidruleta, nombreruleta, oidcilindro, oidplato) VALUES (sequenceruleta.nextval, w_nomruleta, w_oidcil, w_oidplat);

END INSERTARRULETAS;

/

create or replace PROCEDURE INSERTARCONFIGURACIONES (
w_fechainichar in VARCHAR2, 
w_fechafinchar in VARCHAR2, 
w_nombremesa in mesas.nombremesa%TYPE, 
w_codcrupier in empleados.codigoempleado%TYPE, w_codjefemesa in empleados.codigoempleado%TYPE,w_codcilindro in cilindros.codigocilindro%type, w_codplato in platos.codigoplato%type
) AS
w_fechaini DATE;
w_fechafin DATE;
w_oidruleta NUMBER;
w_crupi NUMBER;
w_jefe NUMBER;
w_oidmesa NUMBER;

BEGIN 

w_fechaini := to_date(w_fechainichar,'DD/MM/YYYY HH24:MI:SS');
w_fechafin := to_date(w_fechafinchar,'DD/MM/YYYY HH24:MI:SS');
w_oidruleta := buscaruleta (w_codcilindro, w_codplato);

select mesas.oidmesa into w_oidmesa from mesas where mesas.nombremesa = w_nombremesa;

select oidempleado into w_crupi from empleados where empleados.codigoempleado = w_codcrupier;

select oidempleado into w_jefe from empleados where empleados.codigoempleado = w_codjefemesa;

--dbms_output.put_line(to_char(w_fechaini, 'DD/MM/YYYY HH24:MI:SS'));
--dbms_output.put_line(to_char(w_fechafin, 'DD/MM/YYYY HH24:MI:SS'));

INSERT INTO configuraciones (oidconfiguracion, fechayhorainicio, fechayhorafin, oidempleadocrupier, oidempleadojefemesa, oidmesa, oidruleta)VALUES(sequenceconfiguracion.nextval, w_fechaini, w_fechafin, w_crupi, w_jefe, w_oidmesa, w_oidruleta);

END INSERTARCONFIGURACIONES;

/

create or replace PROCEDURE   INSERTARTIRADAS (
w_codigo IN TIRADAS.CODIGOTIRADA%TYPE, 
w_numero IN TIRADAS.NUMEROGANADOR%TYPE,
w_fechayhoratir IN VARCHAR2, 
w_velocidad IN TIRADAS.VELOCIDADPLATO%TYPE, 
w_nombreMesa IN MESAS.NOMBREMESA%TYPE
) IS
w_fecha tiradas.fechayhoratirada%TYPE;
w_oidconfiguracion configuraciones.oidconfiguracion%TYPE;
w_sentido tiradas.sentidogirobola%TYPE;
w_velocidadabsoluta NUMBER;

BEGIN

w_fecha := to_date(w_fechayhoratir,'DD/MM/YYYY HH24:MI:SS');
w_oidconfiguracion:= CONFIGURACION_MESA_FECHA(W_NOMBREMESA, W_FECHAYHORATIR);

IF w_velocidad>0 THEN 
w_sentido := 'CLOCKWISE';
w_velocidadabsoluta := w_velocidad;
ELSE
w_sentido := 'ANTICLOCKWISE';
 	w_velocidadabsoluta := -w_velocidad;
END IF;

IF  W_OIDCONFIGURACION!=0 THEN
INSERT INTO tiradas(oidtirada, codigotirada, numeroganador, fechayhoratirada, velocidadplato, sentidogirobola,oidconfiguracion)
VALUES (sequencetirada.nextval, w_codigo, w_numero, w_fecha, w_velocidadabsoluta, w_sentido, w_oidconfiguracion );
ELSE
RAISE_APPLICATION_ERROR (-20600,'Configuracion inexistente');
END IF;

END insertartiradaS;

/

create or replace PROCEDURE          INSERTARWINS (
w_jugador IN JUGADORES.CODIGOJUGADOR%TYPE, w_nombremesa IN mesas.nombremesa%TYPE, w_fechayhorawinchar IN VARCHAR2,w_win IN WINS.IMPORTEWIN%TYPE
) IS
w_fecha DATE; 
w_fechachar VARCHAR2(100); 
W_OIDJUGADOR jugadores.oidjugador%TYPE;
w_oidconfiguracion configuraciones.oidconfiguracion%TYPE;

BEGIN
w_fecha := sesionfin(to_date(w_fechayhorawinchar, 'DD/MM/YYYY'));

w_fechachar := to_char(w_fecha, 'DD/MM/YYYY HH24:MI:SS');

w_oidconfiguracion:= 
CONFIGURACION_MESA_FECHA(W_NOMBREMESA, W_FECHAchar);

SELECT OIDJUGADOR INTO W_OIDJUGADOR FROM JUGADORES WHERE CODIGOJUGADOR = W_JUGADOR;

IF  W_OIDCONFIGURACION!=0 THEN
INSERT INTO wins(oidwin, importewin,fechayhorawin,OIDJUGADOR, OIDCONFIGURACION) VALUES (sequencewin.nextval, w_win, w_fecha,W_OIDJUGADOR, w_oidconfiguracion);
ELSE
RAISE_APPLICATION_ERROR (-20600,'Configuracion inexistente');
END IF;

END insertarwins;

/

create or replace PROCEDURE          INSERTARDROPS (
w_jugador IN JUGADORES.CODIGOJUGADOR%TYPE, w_nombremesa IN mesas.nombremesa%TYPE, w_fechayhoradropchar IN VARCHAR2,w_drop IN DROPS.IMPORTEDROP%TYPE
) IS
w_fecha DATE; 
w_fechachar VARCHAR2(100);
W_OIDJUGADOR jugadores.oidjugador%TYPE;
w_oidconfiguracion configuraciones.oidconfiguracion%TYPE;

BEGIN

w_fecha := sesionfin(to_date(w_fechayhoraDROPchar, 'DD/MM/YYYY'));

w_fechachar := to_char(w_fecha,'DD/MM/YYYY HH24:MI:SS');
w_oidconfiguracion:= 

CONFIGURACION_MESA_FECHA(W_NOMBREMESA, W_fechachar);
SELECT OIDJUGADOR INTO W_OIDJUGADOR FROM JUGADORES WHERE CODIGOJUGADOR = W_JUGADOR;

IF W_OIDCONFIGURACION!=0  THEN
INSERT INTO drops(oiddrop, importedrop,fechayhoradrop,OIDJUGADOR, OIDCONFIGURACION) VALUES (sequencedrop.nextval, w_drop, w_fecha,W_OIDJUGADOR, w_oidconfiguracion);
ELSE
RAISE_APPLICATION_ERROR (-20600,'Configuracion inexistente');
END IF;

END insertardrops;

/

create or replace PROCEDURE INSERTARRESULTADOSTIRADAS (
w_codigojugador in jugadores.codigojugador%TYPE, w_codigotirada in tiradas.codigotirada%type, w_cantidadganada in resultadostiradas.cantidadganada%type, w_cantidadapostada resultadostiradas.cantidadapostada%type
) AS
w_oidjugador jugadores.oidjugador%TYPE;
w_oidtirada tiradas.oidtirada%TYPE;

BEGIN 

select oidjugador into w_oidjugador from jugadores where codigojugador = w_codigojugador;

select oidtirada into w_oidtirada from tiradas where codigotirada=w_codigotirada;

INSERT INTO resultadostiradas (oidrestirada, cantidadganada, cantidadapostada, oidjugador, oidtirada) VALUES (sequenceresultadotirada.nextval, w_cantidadganada, w_cantidadapostada, w_oidjugador, w_oidtirada);

END INSERTARRESULTADOSTIRADAS;

/

create or replace PROCEDURE PROCEDIMIENTO_RENDIMIENTO (
w_NOMBREcrupier IN empleados.nombreempleado%TYPE, 
w_fechai IN varchar2, w_fechaf IN varchar2
) AS 
w_literal VARCHAR2(100);
w_Count NUMBER;
w_codempleado empleados.codigoempleado%TYPE;
w_res VARCHAR2(150);
w_nombrecompleto empleados.nombreempleado%TYPE;

BEGIN
w_literal := '%' || w_nombrecrupier || '%';

select count(*) into w_Count from empleados where nombreempleado LIKE w_literal;

IF w_count > 1 THEN 
dbms_output.put_line('Existen ' || w_count || ' empleados con ese nombre. Afine más la búsqueda');
ELSE IF w_count = 0 THEN 
dbms_output.put_line('No existe ningún empleado con ese nombre. Cambie la búsqueda.');
ELSE 
selecT codigoempleado, nombreempleado into w_codempleado,w_nombrecompleto from empleados where nombreempleado LIKE w_literal;
       
w_res := rendimiento (w_codempleado, w_fechai, w_fechaf);
dbms_output.put_line('El empleado ' || w_nombrecompleto || w_res);
END IF;
END IF;

END PROCEDIMIENTO_RENDIMIENTO;

/

create or replace PROCEDURE PROPUESTACAMBIOCILINDRO (
w_nombremesa IN mesas.nombremesa%TYPE
)AS 
w_cilindroprop cilindros.codigocilindro%TYPE;
w_fechamin DATE;

BEGIN

select codigocilindro into w_cilindroprop from cilindros where estadocilindro = 'OPERATIVO' AND rownum=1 AND codigocilindro NOT IN (select distinct codigocilindro from cilindros,configuraciones,mesas,ruletas where mesas.nombremesa = w_nombremesa AND mesas.oidmesa = configuraciones.oidmesa AND configuraciones.oidruleta = ruletas.oidruleta AND ruletas.oidcilindro = cilindros.oidcilindro);

dbms_output.put_line('En la mesa ' || w_nombremesa || ' se puede instalar el cilindro ' ||  w_cilindroprop || ' que nunca se ha usado en esta mesa');

exception  when no_data_found then

select min(fechamax) into w_fechamin from (select codigocilindro,max(configuraciones.fechayhorainicio) as fechamax from cilindros,configuraciones,mesas,ruletas where mesas.nombremesa=w_nombremesa AND mesas.oidmesa = configuraciones.oidmesa AND configuraciones.oidruleta = ruletas.oidruleta AND ruletas.oidcilindro = cilindros.oidcilindro AND estadocilindro='OPERATIVO' GROUP BY codigocilindro);
  
select codigocilindro into w_cilindroprop from cilindros, configuraciones, ruletas where configuraciones.oidruleta = ruletas.oidruleta AND ruletas.oidcilindro = cilindros.oidcilindro AND configuraciones.oidconfiguracion = configuracion_mesa_fecha (w_nombremesa, to_char(w_fechamin,'DD/MM/YYYY HH24:MI:SS'));
    
dbms_output.put_line('En la mesa ' || w_nombremesa || ' se puede instalar el cilindro ' ||  w_cilindroprop || ' que no se usa en esta mesa desde ' || w_fechamin );

END PROPUESTACAMBIOCILINDRO;

/

create or replace PROCEDURE NUMEROHOT_DIA (
W_FECHAACTUAL IN VARCHAR2, 
W_NOMBRE_MESA IN MESAS.NOMBREMESA%TYPE 
) IS
W_FAUX DATE; 
W_SESIONINICIO DATE;
W_SESIONFIN DATE;
w_numganador NUMBER;
w_count NUMBER;
w_num number;
w_nummax number;
w_literal VARCHAR2(100);
w_countnumeroshot NUMBER;
w_numero NUMBER;

CURSOR CURSOR_NUMHOT IS 
SELECT NUMEROGANADOR, COUNT(*) FROM CONFIGURACIONES,MESAS,TIRADAS WHERE W_NOMBRE_MESA = MESAS.NOMBREMESA AND MESAS.OIDMESA= CONFIGURACIONES.OIDMESA 
AND TIRADAS.OIDCONFIGURACION=CONFIGURACIONES.OIDCONFIGURACION
AND TIRADAS.FECHAYHORATIRADA BETWEEN  W_SESIONINICIO AND W_SESIONFIN GROUP BY NUMEROGANADOR ORDER BY 2 DESC;

BEGIN 

w_countnumeroshot := 0;
w_literal := '';
W_FAUX:= TO_DATE(W_FECHAACTUAL, 'DD/MM/YYYY'); 
W_SESIONINICIO:=SESIONINICIO(W_FAUX);
W_SESIONFIN:=SESIONFIN(W_FAUX);

OPEN CURSOR_NUMHOT;
select max(repeticiones) into w_nummax from (SELECT NUMEROGANADOR, COUNT(*) as repeticiones FROM CONFIGURACIONES,MESAS,TIRADAS 
WHERE W_NOMBRE_MESA = MESAS.NOMBREMESA AND MESAS.OIDMESA= CONFIGURACIONES.OIDMESA AND TIRADAS.OIDCONFIGURACION=CONFIGURACIONES.OIDCONFIGURACION
AND TIRADAS.FECHAYHORATIRADA BETWEEN  W_SESIONINICIO AND W_SESIONFIN GROUP BY NUMEROGANADOR);

dbms_output.put_line(w_nummax);

LOOP
fetch cursor_numhot into w_numero,w_count;
EXIT WHEN cursor_numhot%NOTFOUND OR w_count!=w_nummax;
  	w_countnumeroshot := w_countnumeroshot+1;

if w_countnumeroshot = 1 THEN
w_literal := w_numero;
else
w_literal := w_literal || ', ' || w_numero;
end if;
end loop;

if w_countnumeroshot = 1 THEN
w_literal := 'El número hot es: ' || w_literal || ' con ' || w_nummax || ' repeticiones en la mesa ' || w_nombre_mesa;
else 
w_literal := 'Los números hot son: ' || w_literal || ' con ' || w_nummax || ' repeticiones en la mesa ' || w_nombre_mesa;
end if;

dbms_output.put_line(w_literal);

END NUMEROHOT_DIA;

/

create or replace TRIGGER TRI_CONFIGURACIONES 
BEFORE INSERT ON CONFIGURACIONES FOR EACH ROW 

DECLARE
W_NOMBREMESA VARCHAR2(50); 
W_FECHAFINANTERIOR DATE; 
W_OIDCONFIANTERIOR CONFIGURACIONES.OIDCONFIGURACION%TYPE; 

BEGIN

select nombremesa into w_nombremesa from mesas where mesas.oidmesa=:NEW.oidmesa;
w_oidconfianterior := configuracion_mesa_fecha( w_nombremesa, to_char(:new.fechayhorainicio,'DD/MM/YYYY HH24:MI:SS'));

if w_oidconfianterior !=0 THEN 
-- existe una configuracion para la mesa y la fecha inicial que se inserta
update configuraciones set fechayhorafin = (:NEW.fechayhorainicio-INTERVAL '1' second) where oidconfiguracion=w_oidconfianterior;
end if;

END TRI_CONFIGURACIONES;

/

create or replace TRIGGER TRI_estadocilindro 
BEFORE UPDATE OF estadocilindro ON cilindros FOR EACH ROW 

DECLARE
W_Fechaux DATE;
W_COUNT NUMBER; 
W_ESTADONEW CILINDROS.ESTADOCILINDRO%TYPE; 
W_OIDCILINDRONEW CILINDROS.OIDCILINDRO%TYPE; 
  
BEGIN 

if :NEW.estadocilindro = 'DEFECTUOSO' AND :old.estadocilindro = 'OPERATIVO' then 
W_FECHAUX := TO_DATE('31/12/2099   23:59:59' , 'DD/MM/YYYY HH24:MI:SS');
  	
SELECT COUNT(*)  INTO W_COUNT FROM CONFIGURACIONES, RULETAS, CILINDROS WHERE cilindros.OIDCILINDRO = :NEW.oidcilindro AND RULETAS.OIDRULETA = CONFIGURACIONES.OIDRULETA AND CONFIGURACIONES.FECHAYHORAFIN = W_FECHAUX;
  
IF W_COUNT !=0  THEN 
RAISE_APPLICATION_ERROR(-20600,'NO SE PUEDE CAMBIAR DE ESTADO PORQUE ESTA EN UNA CONFIGURACION ACTUAL');
END IF;
  END IF;
  
END TRI_ESTADOCILINDRO;

/

create or replace TRIGGER TRI_INSERTDROPFECHA
BEFORE INSERT ON DROPS FOR EACH ROW 

DECLARE

BEGIN 
IF :NEW.FECHAYHORADROP>sesionfin(SYSDATE) THEN
RAISE_APPLICATION_ERROR (-20600,'LA FECHA Y HORA DEL DROP ES INVALIDA PORQUE ES > QUE LA ACTUAL');
END IF; 

END TRI_INSERTDROPFECHA;

/
