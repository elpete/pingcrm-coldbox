component {

    function up( schema, query ) {
        schema.create( "organizations", function ( table ) {
            table.increments( "id" );
            table.unsignedInteger( "account_id" ).references( "id" ).onTable( "accounts" );
            table.string( "name", 100 );
            table.string( "email", 50 ).nullable();
            table.string( "phone", 50 ).nullable();
            table.string( "address", 150 ).nullable();
            table.string( "city", 50 ).nullable();
            table.string( "region", 50 ).nullable();
            table.string( "country", 2 ).nullable();
            table.string( "postal_code", 25 ).nullable();
            table.timestamp( "created_date" );
            table.timestamp( "modified_date" );
            table.timestamp( "deleted_date" ).nullable();
        } );
    }

    function down( schema, query ) {
        schema.drop( "organizations" );
    }

}
