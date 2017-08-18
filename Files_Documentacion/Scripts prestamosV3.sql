create database prestamosV3;

use prestamos;


-- tabla de login


create table login(id_login int not null primary key auto_increment, usuario varchar(50), password varchar(50));


--	datos de la tabla de ejemplo

	insert into login values(null,"Administrador","pass123");
	insert into login values(null,"yelc","123");	


-- crear tabla de clientes


create table cliente(id_cliente int not null primary key auto_increment, nombre varchar(50), apellido varchar(50),
					 telefono int, direccion_personal varchar(50), direccion_negocio varchar(50), descripcion_negocio varchar(75));



-- datos de la tabla de ejemplo

	insert into cliente values(null,"Wendy","Gonzales",23341175,"Olinteque,Quetzaltenango","Zona 3, Quetzaltenango","Empresa de venta de ropa");
	insert into cliente values(null,"Jorge","Herrera",23456489,"Salcaja","Salcaja Zona 1","Venta de repuestos de computadoras");


-- crear tabla cobradores 

create table cobrador(id_cobrador int not null primary key auto_increment, nombre varchar(50), apellido varchar(50),
					 telefono_personal int, telefono_empresa int, saldo int);


-- datos de la tabla de ejemplo

	insert into cobrador values(null,"Yonathan","Lopez",34086548,55755068,3500);
	insert into cobrador values(null,"Byron","Reyes",45789515,5616379,3700);




-- crear tabla bancos

create table banco(id_banco int not null primary key auto_increment, banco varchar(50), nombre_cuenta varchar(50), numero_cuenta varchar(50), saldo_cuenta int);


-- datos de la tabla de ejemplo

	insert into banco values(null,"BanRural","Fredy Lopez","340-86548",250000);
	insert into banco values(null,"MiCope","Fredy Lopez","457-89515",10000);
	insert into banco values(null,"BanRural","Ernesto Perez","457-89515",12000);
	insert into banco values(null,"Bantrab","Marvin Garcia","211-89515",13000);	
	insert into banco values(null,"Interbanco","Xeila Hernandez","415-89515",60000);	


-- crear tabla depositos 

create table deposito(id_deposito int not null primary key auto_increment, id_bancoR int, foreign key(id_bancoR) references banco(id_banco)
					  , fecha_deposito date , cantidad_deposito int , id_cobradorR int , foreign key(id_cobradorR) references cobrador(id_cobrador));


-- datos de la tabla de ejemplo

	insert into deposito values(null,1,"2016-05-04",4000,1);
	insert into deposito values(null,2,"2016-05-14",2000,2);
	insert into deposito values(null,1,"2016-05-24",3000,3);
	insert into deposito values(null,3,"2016-06-01",4500,4);
	insert into deposito values(null,4,"2016-06-15",2700,1);
    insert into deposito values(null,5,"2016-06-15",3700,2);
	insert into deposito values(null,5,"2016-06-15",4500,2);


-- crear tabla retiros 

create table retiro(id_retiro int not null primary key auto_increment, id_bancoR int, foreign key(id_bancoR) references banco(id_banco)
					  , fecha_retiro date , cantidad_retiro int , id_cobradorR int , foreign key(id_cobradorR) references cobrador(id_cobrador));


-- datos de la tabla de ejemplo

	insert into retiro values(null,2,"2017-05-14",6000,2);
	insert into retiro values(null,1,"2017-05-24",1000,3);
	insert into retiro values(null,4,"2017-05-03",200,4);
	insert into retiro values(null,5,"2017-06-12",4560,1);
	insert into retiro values(null,1,"2017-06-21",6551,3);
    insert into retiro values(null,2,"2017-06-11",2400,4);
	insert into retiro values(null,5,"2017-06-12",5400,3);

	

-- trigers para actualizar saldo de cuenta de los bancos

DROP TRIGGER IF EXISTS `NuevoDeposito`;CREATE DEFINER=`root`@`localhost` TRIGGER `NuevoDeposito` AFTER INSERT ON `deposito` FOR EACH ROW UPDATE banco set banco.saldo_cuenta = banco.saldo_cuenta + new.cantidad_deposito where new.id_bancoR = banco.id_banco 

DROP TRIGGER IF EXISTS `NuevoDeposito`;CREATE DEFINER=`root`@`localhost` TRIGGER `NuevoRetiro` AFTER INSERT ON `retiro` FOR EACH ROW UPDATE banco set banco.saldo_cuenta = banco.saldo_cuenta - new.cantidad_retiro where new.id_bancoR = banco.id_banco 


-- crear tabla de rutas


create table ruta(id_ruta int not null primary key auto_increment, ubicacion varchar(50), departamento varchar(50));

-- datos de la tabla de ejemplo

	insert into ruta values(null,"Zona 3 Quetzaltenango","Quetzaltenango");
	insert into ruta values(null,"Zona 7 Quetzaltenango","Quetzaltenango");
	insert into ruta values(null,"San Perdro","San Marcos");	



// tabla prestamos

create table prestamo(id_prestamo int not null primary key auto_increment, id_clienteR int, foreign key(id_clienteR) references cliente(id_cliente), fecha_prestamo date , monto_prestamo int , monto_a_pagar int , id_rutaR int, foreign key(id_rutaR) references ruta(id_ruta));


-- datos de la tabla de ejemplo
	insert into prestamo values(null,"2","2017-05-29",4000,600,"2");
	insert into prestamo values(null,"1","2017-05-29",2000,300,"2");
	insert into prestamo values(null,"3","2017-05-29",1000,150,"3");
	insert into prestamo values(null,"4","2017-05-29",2000,350,"4");	


-- crear tabla estadoPrestamo

create table estadoPrestamo(id_estado int not null primary key auto_increment , id_prestamoR int, foreign key(id_prestamoR) references prestamo(id_prestamo),
total_dias_prestamo int , nivel_confianza nvarchar(50));


-- crear tabla cuadre

 create table cuadre(id_cuadre int not null primary key auto_increment , fecha_cuadre date, total_cobros int, total_prestamos int, total_gastos int);

-- crear tabla detalles cuadre
 
 create table detalles_cuadre(id_detalle int not null primary key, efectivo_oficina int, efectivo_bancos int , id_cuadreR int, foreign key
 	(id_cuadreR) references cuadre(id_cuadre));




-- crear tabla cobro

create table cobro(id_cobro int not null primary key auto_increment , fecha_cobro date , id_prestamoR int, foreign key
	(id_prestamoR) references prestamo(id_prestamo) , id_cobradorR int , foreign key(id_cobradorR) references cobrador(id_cobrador),
	id_detalleR int , foreign key(id_detalleR) references detalles_cuadre(id_detalle), no_pago int, cantidad_prestamo_restante int);




-- crear tabla cobrador_rutas

create table cobrador_rutas(id_cr int not null primary key auto_increment, id_cobradorR int , foreign key (id_cobradorR) references cobrador(id_cobrador),
	id_rutaR int, foreign key(id_rutaR) references ruta(id_ruta));




	-- procedimiento almacenado para insertar un nuevo cliente

	DELIMITER $
create PROCEDURE InsertarCliente(in nombre varchar(50) , in apellido varchar(50), in telefono int(11), in direccion_personal varchar(50)
                                 , in direccion_negocio varchar(50), in descripcion_negocio varchar(50))
BEGIN
	INSERT into cliente VALUES (nombre, apellido, telefono, direccion_personal, direccion_negocio, descripcion_negocio);
END $



DELIMITER $
CREATE PROCEDURE actualizarCliente(in d1 varchar(50), in d2 varchar(50),  in d3 int, in d4 varchar(50), in d5 varchar(50), in d6 varchar(75), in aux1 varchar(50), in aux2 varchar(50))
BEGIN
	UPDATE cliente set cliente.nombre = d1 , cliente.apellido = d2 , cliente.telefono = d3 , cliente.direccion_personal = d4 , cliente.direccion_negocio = d5 , cliente.descripcion_negocio = d6 WHERE cliente.nombre = aux1 and cliente.apellido = aux2;
END $



DELIMITER $
create PROCEDURE insertarCobrador(in nombre varchar(50) , in apellido varchar(50), in telefono_personal int(11), in telefono_empresa int, in saldo int )
BEGIN
	INSERT into cobrador VALUES (nombre, apellido, telefono_personal, telefono_empresa, saldo);
END $


DELIMITER $
create PROCEDURE actualizarCobrador(in nombre varchar(50) , in apellido varchar(50), in telefono_personal int(11), in telefono_empresa int, in saldo int , in aux1 varchar(50), in aux2 varchar(50))
BEGIN
	UPDATE cobrador set cobrador.nombre =nombre, cobrador.apellido = apellido, cobrador.telefono_personal = telefono_personal, cobrador.telefono_empresa = telefono_empresa, cobrador.saldo = saldo where cobrador.nombre = aux1 and cobrador.apellido = aux2;
END $



DELIMITER $
CREATE PROCEDURE insertarDeposito(in nomCobrador varchar(50), in apeCobrador varchar(50), in fecha date, in monto int, in nomCuenta varchar(50), in noCuenta varchar(50))
BEGIN
	DECLARE claveCobrador int;
    DECLARE claveBanco int;
	set claveCobrador = (select id_cobrador from cobrador WHERE cobrador.nombre = nomCobrador and cobrador.apellido = apeCobrador);
    set claveBanco = (select id_banco from banco WHERE banco.nombre_cuenta = nomCuenta and banco.numero_cuenta = noCuenta);
    INSERT into deposito values(null, claveBanco, fecha, monto, claveCobrador);     
END $


DELIMITER $
CREATE PROCEDURE insertarRetiro(in nomCobrador varchar(50), in apeCobrador varchar(50), in fecha date, in monto int, in nomCuenta varchar(50), in noCuenta varchar(50))
BEGIN
	DECLARE claveCobrador int;
    DECLARE claveBanco int;
	set claveCobrador = (select id_cobrador from cobrador WHERE cobrador.nombre = nomCobrador and cobrador.apellido = apeCobrador);
    set claveBanco = (select id_banco from banco WHERE banco.nombre_cuenta = nomCuenta and banco.numero_cuenta = noCuenta);
    INSERT into retiro values(null, claveBanco, fecha, monto, claveCobrador);     
END $



DELIMITER $

CREATE PROCEDURE insertarRuta(in ubicacion varchar(50), in departamento varchar(50))
BEGIN
	insert into ruta VALUES(null,ubicacion,departamento);

END $


DELIMITER $

CREATE PROCEDURE actualizarRuta(in ubicacion varchar(50), in departamento varchar(50), in oldUbicacion varchar(50), in oldDepartamento varchar(50))
BEGIN
	UPDATE ruta set ruta.ubicacion = ubicacion , ruta.departamento = departamento where ruta.ubicacion = oldUbicacion and ruta.departamento = oldDepartamento;
END $


delimiter //
create procedure insertarPrestamo(in nomCliente varchar(50), in apeCliente varchar(50), in fecha_prestamo date, in monto int, in cantidad int, in total double ,in ubicacion varchar(50))
begin
	DECLARE claveCliente int;
    DECLARE claveRuta int;
    
    set claveCliente = (select id_cliente from cliente where cliente.nombre = nomCliente and  cliente.apellido = apeCLiente);
    set claveRuta = (select id_ruta from ruta where ruta.ubicacion = ubicacion);   
    insert into prestamo VALUES(null, claveCliente,fecha_prestamo, monto, cantidad, total , claveRuta);
end//



