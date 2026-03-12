{
  2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
   
   
}


program up1_2;
const
	milquinientos = 1500;
type
	archivo = file of integer;
var
	arch: archivo;
	name: string[50];

procedure informarArch(var arch: archivo);
var suma,num,menores:integer;
	promedio: real;
begin
	suma:=0;
	menores:=0;
	reset(arch);
	while not EOF(arch) do begin
		read(arch,num); {avanzo y leo}
		suma:=suma+num;
		if (num < milquinientos) then
			menores:=menores+1;
	end;
	promedio:=suma / FileSize(arch);
	close(arch);
	writeln(' la cant de numeros menores a 1500 es de: ',menores);
	
	writeln('el promedio de los numeros ingresados es de: ',promedio);
end;

BEGIN
	write('ingresar nombre del arch: ');
	readln(name);
	assign(arch,name);
	informarArch(arch);
END.

