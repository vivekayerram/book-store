using from './catalog-service';
using from '@sap/cds/common';

annotate CatalogService.Books with @odata.draft.enabled;
 annotate CatalogService.Books with @(
     Common.SemanticKey: [title],
    Metadata.layer: #Core,
 UI: {
        SelectionFields: [title, author_ID],
        LineItem:[ 
        {$Type: 'UI.DataField',Value: ID},
       // {$Type: 'UI.DataField',Value: Bookstatus},
        {$Type: 'UI.DataField',Value: title},
        {$Type: 'UI.DataField',Value: authorName, Label:'{i18n>Author Name}'},
        {$Type: 'UI.DataField',Value: author_ID,Label:'{i18n>Author ID}'},
        {$Type: 'UI.DataField',Value: stock},
        {$Type: 'UI.DataField',Value: price},
        {$Type: 'UI.DataField',Value: Language},
       // { Value: Bookstatus },
        ],
  HeaderInfo: {
      TypeName: '{i18n>Book}',
      TypeNamePlural: '{i18n>Books}',
      Title: {Value : title},
      Description: {Value : author.name}
  },
  
  Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}',Target: '@UI.FieldGroup#Details'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Description}',Target: '@UI.FieldGroup#Description'},
          // {$Type: 'UI.ReferenceFacet', Label: '{i18n>Books List}', Target: 'author/@UI.LineItem'},
		],
        FieldGroup#General: {
			Data: [
				{Value: title},
                {Value: author_ID,Label:'{i18n>Author ID}'},
                {Value: genre.name, Label:'{i18n>genres}'},
                {Value: author.name,Label:'{i18n>Author Name}'},
                {Value: genre_ID,Label:'{i18n>Genre ID}'},
               // { Value: Bookstatus },
			]
		},
		FieldGroup#Details: {
			Data: [
                {Value: stock},
                {Value: Language, Label:'{i18n>Book Language}'},
			]
		},
         FieldGroup#Description: {
			Data: [
			 {Value: descr},
                
			]
		},


 }
 );


  annotate CatalogService.Books with {
    ID @title : '{i18n>ID}' @UI.HiddenFilter;
    //Bookstatus  @title : '{i18n>BookStatus}';
    title @title : '{i18n>Title}';
    author @title : '{i18n>Author ID}';
    stock @title : '{i18n>Stock}';
    price @title : '{i18n>Cost}';
    Language @title : '{i18n>Language}';
    
 }
//
annotate CatalogService.Books with{
    author @(Common : {
        FieldControl : #Mandatory,
        ValueList    : {
            CollectionPath  : 'Authors',
            Label           : 'Authors',
            SearchSupported : true,
            Parameters      : [
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'author_ID',
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }
            ]
        }
    });
}



///////////////////////////
annotate CatalogService.Authors with @(
 UI: {
        SelectionFields: [name, ID],
        LineItem:[ 
        {$Type: 'UI.DataField',Value: ID},
        {$Type: 'UI.DataField',Value: name},
 
        ],
  HeaderInfo: {
      TypeName: '{i18n>Authors}',
      TypeNamePlural: '{i18n>Authors}',
      Title: {Value : name},
      Description: {Value : ID}
  },
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Author Details}', Target: '@UI.FieldGroup#AuthorDetails'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Books}', Target: '@UI.FieldGroup#Books'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Books List}', Target: 'books/@UI.LineItem'},

		],
        FieldGroup#AuthorDetails: {
			Data: [
                {Value: ID, Label:'{i18n>Author ID}'},
                {Value: name, Label:'{i18n>Name of the Author}'},
                {Value: dateOfBirth, Label: '{i18n>date Of Birth}'},
                 {Value: placeOfBirth, Label:'{i18n>place Of Birth}'},
                 {Value: dateOfDeath, Label:'{i18n>date Of Death}'},
                 {Value: placeOfDeath, Label:'{i18n>place Of Death}'},
			
			]
		},
        FieldGroup#Books: {
			Data: [
                {Value: books.ID, Label:'{i18n>Book ID}'},
				{Value: books.title, Label:'{i18n>Book Name}'},
                {Value: books.stock, Label:'{i18n>Book Stock}'},
			]
		},
        
	},
 );

  annotate CatalogService.Authors with {
    ID @title : '{i18n>ID}' @UI.HiddenFilter;
    name @title : '{i18n>Title}';
    
 }
///////////////
annotate CatalogService.Genres with @(
 UI: {
        SelectionFields: [name, ID],
        LineItem:[ 
        {$Type: 'UI.DataField',Value: ID},
        {$Type: 'UI.DataField',Value: name},
         {$Type: 'UI.DataField',Value: parent_ID}
        ],
  HeaderInfo: {
      TypeName: '{i18n>Genres}',
      TypeNamePlural: '{i18n>Genres}',
      Title: {Value : name},
      Description: {Value : ID}
  }
 }
 );

  annotate CatalogService.Genres with {
    ID @title : '{i18n>ID}' @UI.HiddenFilter;
    name @title : '{i18n>Title}';
    parent_ID @title : '{i18n>Parent}';
 }

 /////////////////
 annotate CatalogService.Orders with @(
	UI: {
        SelectionFields: [orderID,myBookName],
        LineItem:[ 
           {$Type: 'UI.DataField',Value: orderID},
           {$Type: 'UI.DataField',Value: myBookName}, 
        {$Type: 'UI.DataField',Value: name},
        {$Type: 'UI.DataField',Value: noOfBooks},
        ],

        HeaderInfo:{
        $Type: 'UI.HeaderInfoType',    
        TypeName: '{i18n>Orders}',
        TypeNamePlural: '{i18n>Orders List}',
        Title: {Value: orderID},
        },

		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'}
		],

		FieldGroup#General: {
			Data: [
				{Value: book_ID,Label:'{i18n>Books ID}'},
                {Value: name,Label:'{i18n>Order Name}'},
			]
		} 
	},

);

annotate CatalogService.Orders with {
    name @title:'{i18n>Order Name}';
    noOfBooks @title:'{i18n>No of Books}';
    myBookName @title:'{i18n>Books Name}';
    orderID @title:'{i18n>Order ID}';
}

// annotate CatalogService.Orders with {
//     myBookName @(Common : {
//         FieldControl : #Mandatory,
//         ValueList    : {
//             CollectionPath  : 'Orders',
//             Label           : 'Orders',
//             SearchSupported : true,
//             Parameters      : [
//                 {
//                     $Type             : 'Common.ValueListParameterOut',
//                     LocalDataProperty : 'myBookName',
//                     ValueListProperty : 'myBookName'
//                 }
//             ]
//         }
//     });
// }
