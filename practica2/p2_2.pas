{Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
a.
 Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado,
y se decrementa en uno la cantidad de materias sin final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b.
 Listar en un archivo de texto aquellos alumnos que tengan más materias con finales
aprobados que materias sin finales aprobados. Teniendo en cuenta que este listado
es un reporte de salida (no se usa con fines de carga), debe informar todos los
campos de cada alumno en una sola línea del archivo de texto.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.

ME FALTARIA METER LO DEL PPAL EN UN MODULO, MENOS LOS ASSIGNS}

program untitled;
const  valoralto = 9999;
type
	alumno = record
		nroAlu:integer;
		nombre:string;
		apellido:string;
		cursadas:integer;
		finales:integer;
	end;
	
	materia = record
		cursadaAprobada:boolean;
		finalAprobado:boolean;
	end;
		
	otrosDatos = record
		nroAlu:integer;
		infoMateria:materia;
	end;
	
	maestro = file of alumno;
	detalle = file of otrosDatos;
	
procedure leerM(var mae1:maestro; var a:alumno);
begin
	if not EOF(mae1) then
		read(mae1, a)
	else a.nroAlu := valoralto;
end;

procedure leerD(var det1:detalle; var d:otrosDatos);
begin
	if not EOF(det1) then
		read(det1, d)
	else d.nroAlu := valoralto;
end;
	
	
var
	mae1:maestro; det1:detalle; a:alumno; d:otrosDatos; nroDactual: integer;
	archtxt: text;
BEGIN
	assign(mae1,'maestro');
	assign(det1,'detalle');
	assign(archtxt,'textop2_2');
	reset(mae1);
	reset(det1);
	leerM(mae1, a);
	leerD(det1, d);
	while (a.nroAlu <> valoralto) do begin
		while (d.nroAlu < a.nroAlu) do
			leerD(det1,d);
		if (d.nroAlu = a.nroAlu) then begin
			nroDactual := d.nroAlu;
			while (d.nroAlu <> valoralto) and (nroDactual = d.nroAlu) do begin
				if (d.infoMateria.cursadaAprobada) then
					a.cursadas := a.cursadas +1;
				if (d.infoMateria.finalAprobado) then begin
					a.finales := a.finales + 1;
					a.cursadas := a.cursadas -1;
				end;
				leerD(det1,d);
			end;
		end;
		seek(mae1,filepos(mae1)-1);
		write(mae1,a);
		leerM(mae1,a);
	end;
	close(det1);
	
	seek(mae1,0);
	rewrite(archtxt);
	leerM(mae1,a);
	while (a.nroAlu <> valoralto) do begin
		if (a.finales > a.cursadas) then
			writeln(archtxt,a.nroAlu,a.nombre,a.apellido,a.cursadas,a.finales);
		leerM(mae1,a);
	end;
	
	close(mae1);  close(archtxt);
END.

