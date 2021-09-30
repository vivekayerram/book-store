using my.bookshop as my from '../db/schema';


service CatalogService{
    @Capabilities : { Insertable:true, Deletable:true, Updatable:true}
    entity Books as projection on my.Books;
    
   @Capabilities : { Insertable:true, Deletable:false, Updatable:true}
   entity Authors as projection on my.Authors;

    @Capabilities : { Insertable:true, Deletable:false, Updatable:true}
    entity Genres as projection on my.Genres;

     @Capabilities : { Insertable:true, Deletable:false, Updatable:true}
    entity Orders as projection on my.Orders;
}

