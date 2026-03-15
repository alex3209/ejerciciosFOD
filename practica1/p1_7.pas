program p1_7;
type
	novela = record
		codigo:integer;
		nombre:string[70];
		genero:string[50];
		precio:real;
	end;
	
	archivo = file of novela;

procedure puntoA(var arch:archivo; var archtxt:text);
var n:novela; nombre:string;
begin
	write('ingresar nombre del archivo binario: ');
	readln(nombre);
	assign(arch, nombre);
	assign(archtxt,'novelas.txt');
	reset(archtxt);
	rewrite(arch);
	while (not EOF(archtxt)) do begin
		readln(archtxt,n.codigo,n.precio,n.genero);
		readln(archtxt, n.nombre);
		write(arch,n);
	end;
	close(arch);
	close(archtxt);
end;
procedure nuevaNovela(var arch:archivo; agregarOK:boolean; codigoNuevo:integer);
var n:novela;
begin
	if agregarOK then begin
		n.codigo:=codigoNuevo;
		writeln('ingresar nombre');
		readln(n.nombre);
		writeln('ingresar genero');
		readln(n.genero);
		writeln('ingresar precio');
		readln(n.precio);
		seek(arch,FileSize(arch));
		write(arch, n);
	end;
end;

procedure modificarNexistente(var n:novela);
begin
	writeln('ingresar nombre');
	readln(n.nombre);
	writeln('ingresar genero');
	readln(n.genero);
	writeln('ingresar precio');
	readln(n.precio);
end;


procedure puntoB(var arch:archivo);
var n:novela; agregarOK:boolean; existe:boolean;
	codigoNuevo:integer; codigoExistente:integer;
begin
	agregarOK:=true;
	existe:=false;
	reset(arch);
	writeln('ingresar codigo nuevo para agregar');
	readln(codigoNuevo);
	writeln('ingresar codigo existente para editar');
	readln(codigoExistente);
	while (not EOF(arch)) do begin
		read(arch,n);
		if (n.codigo = codigoNuevo) then 
			agregarOK := false;
		
		if (n.codigo = codigoExistente) then begin
			existe := true;
			modificarNexistente(n);
			seek(arch,FilePos(arch)-1);
			write(arch,n);
		end;
	end;
    nuevaNovela(arch, agregarOK, codigoNuevo);
    close(arch);		
end;

var
	arch:archivo;
	archtxt:text;
	
BEGIN
	puntoA(arch,archtxt);
	puntoB(arch);
END.

