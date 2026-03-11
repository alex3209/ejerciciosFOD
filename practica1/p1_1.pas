program p1_1;
const tresmil = 3000;
type
	archivo = file of integer;
var
	arch: archivo;
	nombreArch: string[50];

procedure crearArch(var arch:archivo);
var numero:integer;
begin
	rewrite(arch);
	write('ingresar un numero');
	readln(numero);
	while (numero <> tresmil) do begin
		write(arch, numero);
		write('ingresar un numero');
		readln(numero);
	end;
	close(arch);	
end;

BEGIN
	write('ingresar nombre del archivo: ');
	readln(nombreArch);
	assign(arch, nombreArch);
	crearArch(arch);
END.

