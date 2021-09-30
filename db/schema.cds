namespace my.bookshop;
using { Country,Currency,managed,cuid,sap,Language} from '@sap/cds/common';

@cds.search : {title,author}
entity Books : managed {
  key ID : Integer;
  title  : localized String(111);
  descr  : localized String(1111);
  author : Association to Authors;
  genre  : Association to Genres;
  order: Association to Orders;
  authorName : String;

   Bookstatus: Integer  
        enum {
            veryUnsatisfied = 1;
            unsatisfied = 2;
            neutral = 3;
            satisfied = 4;
            verySatisfied = 5
        };
  stock  : Integer;
  Language: String;
  price  : Decimal;
  currency : Currency;
  image : LargeBinary @Core.MediaType : 'image/png';
}



entity Authors : managed {
  key ID : Integer;
  name   : String(111);
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books  : Association to many Books on books.author = $self;
}

entity Genres : sap.common.CodeList {
  key ID   : Integer;
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}

entity Orders{
    key orderID: UUID @odata.Type:'Edm.String';
    name : String;
    noOfBooks: Integer;
    book : Association to Books;
    myBookName: String;
}
