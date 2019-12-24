component {

    function up( schema, query ) {
        schema.create( "accounts", function ( table ) {
            table.increments( "id" );
            table.string( "name", 50 );
            table.timestamp( "created_date" );
            table.timestamp( "modified_date" );
        } );
    }

    function down( schema, query ) {
        schema.drop( "accounts" );
    }

}
