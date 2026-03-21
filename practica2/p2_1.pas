{Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.

Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.

NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.

TIENE UN ERROR PERO NO SE CUAL ES, QUEDA EN BUCLE EN aaaa
}
program p2_1;
const valoralto = 9999;
type
	registro = record
		codigo:integer;
		nombre:string[20];
		comision:real;
	end;
	
	archivo = file of registro;

procedure leer(var arch:archivo; var r:registro);
begin
	if (not EOF(arch)) then
		read(arch,r)
	else r.codigo := valoralto;
end;
	
procedure crearNuevoArch(var arch:archivo; var archNew:archivo);
var
	totalComision:real; codActual:integer; r:registro; nombreActual:string;
begin
	reset(arch);
	rewrite(archNew);
	leer(arch,r);
	while (r.codigo <> valoralto) do begin
		totalComision:=0;
		codActual:=r.codigo;
		nombreActual:=r.nombre;
		while (r.codigo <> valoralto) and (codActual = r.codigo) do begin
			totalComision := totalComision + r.comision;
			leer(arch, r);
			write('aaaa');
		end;
		r.comision:=totalComision;
		r.codigo:=codActual;
		r.nombre:=nombreActual;
		write(archNew, r);
	end;
	close(arch);
	close(archNew);
end;

var
	arch,archNew: archivo;
begin
	assign(arch, 'comisiones');
	assign(archNew, 'comisionesCompactadas');
	crearNuevoArch(arch,archNew);
end.
