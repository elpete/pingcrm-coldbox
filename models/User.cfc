component extends="quick.models.BaseEntity" {

	property name="bcrypt" inject="@BCrypt" persistent="false";

    property name="id";
    property name="accountId" column="account_id";
    property name="firstName" column="first_name";
    property name="lastName" column="last_name";
    property name="email";
    property name="password";
    property name="owner" casts="boolean";
    property name="photoPath" column="photo_path";
    property name="rememberToken" column="remember_token";
    property name="createdDate" column="created_date";
    property name="modifiedDate" column="modified_date";
    property name="deletedDate" column="deleted_date";

    function account() {
        return belongsTo( "Account" );
    }

    function scopeOrderByName( query ) {
        query.orderBy( "lastName" ).orderBy( "first_name" );
    }

    function scopeWhereRole( query, role ) {
        switch ( role ) {
            case "user": return query.where( "owner", 0 );
            case "owner": return query.where( "owner", 1 );
        }
    }

    function scopeFilter( query, struct filters ) {
        query.when( arguments.filters.keyExists( "search" ), function ( query ) {
            query.where( function (query) {
                query.where( "first_name", "like", "%#filters.search#%" )
                    .orWhere( "last_name", "like", "%#filters.search#%" )
                    .orWhere( "email", "like", "%#filters.search#%" );
            });
        } ).when( arguments.filters.keyExists( "role" ), function ( query ) {
            query.whereRole( filters.role );
        } ).when( arguments.filters.keyExists( "trashed" ), function ( query ) {
            if ( filters.trashed == "with") {
                // do nothing
            } else if ( filters.trashed == "only") {
                query.whereNotNull( "deletedDate" );
            } else {
                query.whereNull( "deletedDate" );
            }
        } );
    }

    public User function setPassword( required string password ){
		return assignAttribute( "password", bcrypt.hashPassword( arguments.password ) );
    }

    function getName() {
        return "#this.getFirstName()# #this.getLastName()#";
    }

	public boolean function hasPermission( required string permission ){
		return true;
	}

	public boolean function isValidCredentials( required string email, required string password ){
		var user = newEntity().where( "email", arguments.email ).first();
		if ( !user.isLoaded() ) {
			return false;
		}
		return bcrypt.checkPassword( arguments.password, user.getPassword() );
	}

	public User function retrieveUserByUsername( required string email ){
		return newEntity().where( "email", arguments.email ).firstOrFail();
	}

	public User function retrieveUserById( required numeric id ){
		return newEntity().findOrFail( arguments.id );
	}

	public struct function getMemento() {
        var memento = super.getMemento();
        structDelete( memento, "password" );
        var account = memento.account;
        structDelete( memento, "account" );
        memento[ "account" ] = account;
        return memento;
	}

}
