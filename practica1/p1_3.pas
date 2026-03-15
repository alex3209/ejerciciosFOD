program p1_3;
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

procedure leerDatos(var r:registro; var ok:boolean);
begin
	write('apellido: ');
	readln(r.apellido);
	if (r.apellido <> fin) then begin
		ok:=true;
		write('nombre: ');
		readln(r.nombre);
		write('edad: ');
		readln(r.edad);
		write('nnro: ');
		readln(r.nro);
		write('dni: ');
		readln(r.dni);
	end
	else ok:=false;
end;

procedure cargarArch(var arch:archivo);
var r:registro; ok:boolean;
begin
	leerDatos(r,ok);
	while (ok) do begin
		write(arch,r);
		leerDatos(r,ok);
	end;
end;


procedure puntoB1(var arch:archivo);
var r:registro;
begin
	while (not EOF(arch)) do begin
		read(arch, r);
		if (r.apellido='cebolla') or (r.nombre='juan') then
			writeln('apellido:',r.apellido,', nombre:',r.nombre,', numero:',r.nro,', dni:',r.dni,', edad:',r.edad);
	end;
end;


procedure puntoB2(var arch:archivo);
var r:registro;
begin
	while (not EOF(arch)) do begin
		read(arch, r);
		writeln('apellido:',r.apellido,', nombre:',r.nombre,', numero:',r.nro,', dni:',r.dni,', edad:',r.edad);
	end;
end;

procedure puntoB3(var arch:archivo);
var r:registro;
begin
	while (not EOF(arch)) do begin
		read(arch, r);
		if (r.edad > 70) then
			writeln('apellido:',r.apellido,', nombre:',r.nombre,', numero:',r.nro,', dni:',r.dni,', edad:',r.edad);
	end;
end;

//ppal
VAR
	arch: archivo;
	nombre: string[50];
BEGIN
	readln(nombre);
	assign(arch,nombre);
	rewrite(arch);
	cargarArch(arch);
	seek(arch,0);
	puntoB1(arch);
	seek(arch,0);
	writeln('');
	puntoB2(arch);
	seek(arch,0);
	writeln('');
	puntoB3(arch);
	close(arch);
END.

