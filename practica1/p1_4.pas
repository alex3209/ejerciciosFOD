{“Agregar al menú del programa” significa que el programa no hace todo seguido, sino que el usuario elige qué operación quiere ejecutar.

O sea, el programa muestra opciones como estas:

1 - Agregar empleados
2 - Modificar edad
3 - Exportar todos los empleados
4 - Exportar empleados sin DNI
5 - Salir

El usuario ingresa un número y el programa ejecuta solo esa opción

pero esta mal detallado el ejercicio asi que no hice eso, ademas tome en cuenta q
el archivo del ejercico 3 se llama empleados_ejer3 y existe}

program p1_4;
const fin = 'fin';
type
	registro = record
		edad:integer;
		nro:integer;
		dni:integer;
		nombre:string[50];
		apellido:string[50];
	end;
		
	archivo = file of registro;
	
procedure buscarEmpleado(var arch:archivo; nro:integer; var ok:boolean);
var r:registro;
begin
	ok:=true;
	while ((not EOF(arch)) and (ok)) do begin
		read(arch,r);
		if (nro = r.nro) then
			ok:=false;
	end;
end;

procedure leerDatos(var r:registro; var ok:boolean; var arch:archivo; var seguir:boolean);
begin
	write('apellido: ');
	readln(r.apellido);
	write('nnro: ');
	readln(r.nro);
	seek(arch,0);
	buscarEmpleado(arch,r.nro,ok); 
	if (r.apellido <> fin) and (ok) then begin
		write('nombre: ');
		readln(r.nombre);
		write('edad: ');
		readln(r.edad);
		write('dni: ');
		readln(r.dni);
	end
	else ok:=false;
	seguir := r.apellido <> fin;
end;

procedure cargarArch(var arch:archivo);
var r:registro; ok:boolean; seguir:boolean;
begin
	leerDatos(r,ok,arch,seguir);
	while (seguir) do begin
		if (ok) then begin
			seek(arch,filesize(arch));
			write(arch,r);
		end;
		leerDatos(r,ok,arch,seguir);
	end;
end;

procedure modificarEdad(empleadoNro: integer; var arch:archivo; var esta:boolean);
var r:registro; nuevaEdad: integer;
begin
	esta:=false;
	seek(arch,0);
	while (not EOF(arch) and not esta) do begin
		read(arch,r);
		if (r.nro = empleadoNro) then begin
			write('ingresar nueva edad: ');
			readln(nuevaEdad);
			r.edad := nuevaEdad;
			seek(arch,filepos(arch)-1);
			write(arch,r);
			esta:=true;
		end;
	end;
end;

procedure exportar(var arch:archivo; var archTXT:text; var archTXT2:text);
var r:registro;
begin
	seek(arch,0);
	while (not EOF(arch)) do begin
		read(arch,r);
		writeln(archTXT, r.nro,' ',r.apellido,' ',r.nombre,' ',r.edad,' ',r.dni);
		if (r.dni = 00) then
			writeln(archTXT2, r.nro,' ',r.apellido,' ',r.nombre,' ',r.edad,' ',r.dni);
	end;
end;

//ppal
VAR
	arch: archivo;
	esta: boolean; empleadoNro: integer;
	archTXT: text;
	archTXT2: text;
BEGIN
	assign(arch,'empleados_ejer3');
	assign(archTXT, 'todos_empleados.txt');
	assign(archTXT2, 'faltaDNIEmpleado.txt');
	
	reset(arch);
	rewrite(archTXT);
	rewrite(archTXT2);
	
	cargarArch(arch);
	write('ingresar nro del empleado para modificar edad: ');
	readln(empleadoNro);
	modificarEdad(empleadoNro,arch,esta);
	exportar(arch,archTXT,archTXT2);
	
	close(arch);
	close(archTXT);
	close(archTXT2);
END.


