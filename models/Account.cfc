component extends="quick.models.BaseEntity" {

    property name="id";
    property name="name";
    property name="createdDate" column="created_date";
    property name="modifiedDate" column="modified_date";

    function users() {
        return hasMany( "User" );
    }

}
