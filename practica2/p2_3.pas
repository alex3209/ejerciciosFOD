{
  El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
productos que comercializa. De cada producto se maneja la siguiente información: código de
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
realizar un programa con opciones para:
a.
 Actualizar el archivo maestro con el archivo detalle, sabiendo que:
●
 Ambos archivos están ordenados por código de producto.
●
 Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
●
 El archivo detalle sólo contiene registros que están en el archivo maestro.
b.
 Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.1301, USA.
   
   
}


program p2_3;
const valoralto = 9999;
type
	producto = record
		codigo:integer;
		nombre:string;
		precio:real;
		stockMin:integer;
		stockActual:integer;
	end;
	
	venta = record
		codigo:integer;
		cantUnidadesVendidas:integer;
	end;
	
	maestro = file of producto;
	detalle = file of venta;
	
procedure leerM(var mae1:maestro; var m:producto);
begin
	if not eof(mae1) then read(mae1,m)
	else m.codigo := valoralto;
end;

procedure leerD(var det1:detalle; var d:venta);
begin
	if not eof(det1) then read(det1,d)
	else d.codigo := valoralto;
end;



procedure actualizarMaestro(var mae1:maestro; var det1:detalle);
var
	m:producto; d:venta; codActualD:integer;
begin
	reset(mae1);
	reset(det1);
	leerM(mae1,m);
	leerD(det1,d);
	while (m.codigo <> valoralto) do begin
		while (d.codigo < m.codigo) do
			leerD(det1,d);
		if (d.codigo = m.codigo) then begin
			codActualD:=d.codigo;
			while (d.codigo <> valoralto) and (codActualD = d.codigo) do begin
				m.stockActual := m.stockActual - d.cantUnidadesVendidas;
				leerD(det1,d);
			end;
		end;	
		seek(mae1,filepos(mae1)-1);
		write(mae1,m);
		leerM(mae1,m);
	end;
	close(mae1);
	close(det1);
end;

procedure listarTXTstockMin(var mae1:maestro; var archtxt:text);
var
	m:producto; 
begin
	rewrite(archtxt);
	reset(mae1);

	leerM(mae1,m);
	while (m.codigo <> valoralto) do begin
		if (m.stockActual < m.stockMin) then 
			writeln(archtxt, m.codigo,m.nombre,m.precio,m.stockMin,m.stockActual);
		leerM(mae1,m);
	end;
	close(mae1);
	close(archtxt);
end;

var 
	mae1:maestro; det1:detalle; archtxt:text;
BEGIN
	assign(mae1,'maestro');
	assign(det1,'detalle');
	assign(archtxt,'stockminimo');
	actualizarMaestro(mae1,det1);
	listarTXTstockMin(mae1,archtxt);
END.

