
    function _onload() {
        var add = $("#add").val();
        var update = $("#update").val();
        var deletes = $("#delete").val();

        if (add == "add") {
            $(".add").show();

        } else {
            $(".add").hide();
        }

        if (update == "update") {
            $(".update").show();
        } else {
            $(".update").hide();
        }

        if (deletes == "delete") {
            $(".delete").show();
        } else {
            $(".delete").hide();
        }

    }
