program p1_6;
procedure puntoA(var arch:archivo);
var r:registro; seguir:string;
begin
	reset(arch);
	seek(arch,FileSize(arch));
	repeat
		write('codigo del celular: ');
		readln(r.codCelular);
		
		write('Nombre del celular: ');
		readln(r.nombre);

		write('Descripcion: ');
		readln(r.descripcion);
	
		write('Marca: ');
		readln(r.marca);

		write('Precio: ');
		readln(r.precio);

		write('Stock minimo: ');
		readln(r.stockMin);

		write('Stock disponible: ');
		readln(r.stockDisponible);
		
		write(arch,r);
		
		writeln('desea seguir? s/n');
		readln(seguir);
	until(seguir = 'n');
	close(arch);
end;

procedure puntoB(var arch:archivo; var ok:boolean);
var r:registro; stmNuevo, stdNuevo: integer; nameCelu:string;
begin
	ok:=false;
	reset(arch);
	readln(nameCelu);
	while (not EOF(arch) and ok=false) do begin
		read(arch,r);
		if (r.nombre = nameCelu) then begin
			readln(stmNuevo);
			readln(stdNuevo);
			r.stockMin:=stmNuevo;
			r.stockDisponible:=stdNuevo;
			seek(arch,FilePos(arch)-1);
			write(arch,r);
			ok:=true;
		end;
	end;
	close(arch);
end;

procedure puntoC(var arch:archivo; var arch2:text);
var r:registro;
begin
	reset(arch);
	assign(arch2,'sinStock.txt');
	rewrite(arch2);
	while (not EOF(arch)) do begin
		read(arch,r);
		if (r.stockDisponible = 0) then begin
			writeln(archTXT, r.codCelular, ' ', r.nombre, ' ', r.descripcion, ' ', r.marca);
			writeln(archTXT, r.precio:0:2, ' ', r.stockMin, ' ', r.stockDisponible);
		end;
	end;
	close(arch);
	close(arch2);
end;
	
var
	arch2:text;
BEGIN
	
	
END.

