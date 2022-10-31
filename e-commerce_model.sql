-- criação do banco de dados para o cenário de E-commerce
-- drop database ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;



-- tabela cliente

CREATE TABLE Clients(
		idClient int auto_increment primary key,
        Fname varchar (10),
        Minit char (3),
        Lname varchar(20),
        CPF char (11) not null,
        Address varchar (250),
        constraint unique_cpf_client unique (CPF)    
);

alter table clients auto_increment=1;

-- tabela produto
-- Size = dimensão do produto

CREATE TABLE Product (
		idProduct int auto_increment primary key,
        Pname varchar (10) not null,
        classification_kids bool default false,
        category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos') not null,
        Avaliação float default 0,
        Size varchar (10)
	);



-- tabela pedido

CREATE TABLE Orders (
		idOrder int auto_increment primary key,
        idOrderClient int,
        OrderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references Clients(idClient)        
);


-- tabela pagamento

CREATE TABLE Payments (
		iDClient int,
        idPayment int,
        typePayment enum ('Boleto', 'Cartão', 'Dois Cartões'),
        limitAvailable float,
        constraint fk_payments_client foreign key (idPayment) references Orders (idOrder)        
);


-- tabela estoque

CREATE TABLE ProductStorage (
		idProdStorage int auto_increment primary key,
        StorageLocation varchar(255),
        quantity int default (0)
        );        

-- tabela fornecedor

CREATE TABLE Supplier(
		idSupplier int auto_increment primary key,
		socialName varchar(255) not null,
		CNPJ char(15) not null,
		contact char(11) not null,
		constraint unique_supplier unique (CNPJ)
);

-- tabela vendedor

CREATE TABLE Seller (
		idSeller int auto_increment primary key,
		socialName varchar(255) not null,
		AbstName varchar (255),
		CNPJ char(15),
		CPF char (9),
		location varchar (255),
		contact char(11) not null,
		constraint unique_cnpj_seller unique (CNPJ),
		constraint unique_cpf_seller unique (CPF)
);

CREATE TABLE ProductSeller(
		idPseller int,
        idPproduct int,
        prodQuality int default 1,
        primary key (idPseller, idPproduct),
        constraint fk_product_seller foreign key (idPseller) references Seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references Product(idProduct)
);

CREATE TABLE ProductOrder(
		idPOproduct int,
        idPOorder int,
        prodQuality int default 1,
        poStatus enum ('Disponível', 'Sem estoque') default 'Disponivel',
        primary key (idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key (idPOproduct) references Product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references Orders (idOrder)
);

CREATE TABLE storageLocation(
		idLproduct int,
        idLstorage int,
        Location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storage_location_seller foreign key (idLproduct) references Product(idProduct),
        constraint fk_storage_location_storage foreign key (idLstorage) references productStorage (idProdStorage)
);

CREATE TABLE productSupplier(
		idPsSupplier int,
		idPsProduct int,
		quantity int not null,
		primary key (idPsSupplier, idPsProduct),
		constraint fk_product_supplier_supplier foreign key (idPsSupplier) references Supplier (idSupplier),
		constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

CREATE TABLE Delivery (
		idDelivery int,
        idDproduct int,
        statusDelivery enum ('Aguardando fornecedor', 'Em transito', 'Produto Entregue', 'Produto devolvido por ausência'),
        primary key (idDelivery, idDproduct),
        constraint fk_product_delivery foreign key (idDproduct) references Orders (idOrder)
        );
        
        
                

