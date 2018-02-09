set serveroutput on;

update cilindros set estadocilindro = 'DEFECTUOSO' where codigocilindro = 'C-06-02-037-C7TF'; -- TRIGGER CILINDROS

-- execute INSERTARDROPS('151264', 'RA03', '23/05/2015', '1500'); -- TRIGGER DROPS

-- execute insertarconfiguraciones('23/05/2015 20:41:53','31/12/2099 23:59:59','RA03', '246', '255', 'C-06-02-039-C7TF', 'P-06-02-028-C7TF');

-- select to_char(fechayhorainicio,'DD/MM/YYYY HH24:MI:SS'),to_char(fechayhorafin,'DD/MM/YYYY HH24:MI:SS') from configuraciones where oidconfiguracion IN (1458, 1461); 

-- execute procedimiento_rendimiento ('GARCIA,','01/05/2015','10/05/2015');