program p1_5;
type
	registro = record
		codCelular: integer;
		nombre: string[50];
		descripcion:string;
		marca:string[50];
		precio:real;
		stockMin:integer;
		stockDisponible:integer;
	end;
	
	archivo = file of registro;

var arch: archivo;
	archtxt:text;
	
procedure crearArch(var arch:archivo; var archtxt:text;var aOK: boolean);
var r:registro; nombre:string;
begin
	reset(archtxt);
	write('ingresar nombre del arch binario: ');
	readln(nombre);
	assign(arch,nombre);
	rewrite(arch);
	while (not EOF(archtxt)) do begin
		readln(archtxt, r.codCelular, r.precio, r.marca);
		readln(archtxt, r.stockDisponible, r.stockMin, r.descripcion);
		readln(archtxt, r.nombre);
		write(arch, r);
	end;
	aOK:=true;
	close(archtxt);
	close(arch);
end;

procedure stockLista(var arch:archivo);
var r:registro;
begin
	reset(arch);
	while not (EOF(arch)) do begin
		read(arch,r);
		if (r.stockDisponible < r.stockMin) then
			writeln('cod: ',r.codCelular,' nombre:',r.nombre,' descipcion:',r.descripcion,' marca:',r.marca,' precio:',r.precio,' stock min:',r.stockMin,' stock disponible:',r.stockDisponible);
	end;
	close(arch);
end;

procedure puntoC(var arch:archivo);
var cadena:string;
	r:registro;
begin
	write('ingresar cadena a buscar: ');
	readln(cadena);
	reset(arch);
	while not (EOF(arch)) do begin
		read(arch,r);
		if (pos(cadena,r.descripcion) <> 0) then
			writeln('cod: ',r.codCelular,' nombre:',r.nombre,' descipcion:',r.descripcion,' marca:',r.marca,' precio:',r.precio,' stock min:',r.stockMin,' stock disponible:',r.stockDisponible);
	end;
	close(arch);
end;		

procedure puntoD(var arch:archivo; var archtxt:text);
var c:registro;
begin
	rewrite(archtxt);
	reset(arch);
	while not EOF(arch) do begin
		read(arch,c);
		writeln(archtxt, c.codCelular,' ',c.precio,' ',c.marca);
		writeln(archtxt, c.stockDisponible,' ',c.stockMin,' ',c.descripcion);
		writeln(archtxt, c.nombre);
	end;
	close(archtxt);
	close(arch);
end;


var 
	aOK:boolean; num:integer;
BEGIN
	aOK:=false;
	assign(archtxt,'celulares.txt');
	writeln('1 para punto A');
	writeln('2 para punto B');
	writeln('3 para punto C');
	writeln('4 para punto D');
	write('ingresar: ');
	repeat
		readln(num);
		if (num = 1) then begin
			crearArch(arch,archtxt,aOK);
			write('ingresar: ');
		end
		else if (num=2) then
			if (aOK) then begin
				stockLista(arch);
				write('ingresar: ');
			end
		else if (num=3) then
			if (aOK) then begin
				puntoC(arch);
				write('ingresar: ');
			end
		else if (num=4) then
			if aOK then begin
				puntoD(arch,archtxt);
				write('ingresar: ');
			end;
	until(num = 0);
END.

