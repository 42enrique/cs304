<!--Test Oracle file for UBC CPSC304 2018 Winter Term 1
  Created by Jiemin Zhang
  Modified by Simona Radu
  Modified by Jessica Wong (2018-06-22)
  This file shows the very basics of how to execute PHP commands
  on Oracle.
  Specifically, it will drop a table, create a table, insert values
  update values, and then query for values

  IF YOU HAVE A TABLE CALLED "demoTable" IT WILL BE DESTROYED

  The script assumes you already have a server set up
  All OCI commands are commands to the Oracle libraries
  To get the file to work, you must place it somewhere where your
  Apache server can run it, and you must rename it to have a ".php"
  extension.  You must also change the username and password on the
  OCILogon below to be your ORACLE username and password -->

<html>

<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">
    <title>Group 4: Social Media App</title>
</head>

<body>
    <div style="display: flex; width: 100%; height: 90vh; gap: 20px; border: 1px solid grey; padding: 20px;">
        <div style="width: 60%; overflow: auto;">
            <h2>INSERT: Create Account</h2>
            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <div style="display:flex; gap: 20px;">
                    <div>
                        <input type="hidden" id="createAccountRequest" name="createAccountRequest">
                        Account ID: <input type="number" name="accountID">
                        Email: <input type="text" name="email">
                        Username: <input type="text" name="username">
                        Password: <input type="text" name="password">
                        Full Name: <input type="text" name="name">
                    </div>
                    <div>
                        Today's Date: <input type="date" name="dateCreated">
                        Your Birthday: <input type="date" name="birthday">
                        Country of Origin: <input type="text" name="country">
                        Top Interest: <input type="text" name="top_interest">
                        Favourite Color: <input type="text" name="color">
                    </div>
                </div>
                <input type="submit" value="Create My Account" name="insertSubmit" />
            </form>
            <hr />

            <h2>DELETE: Delete Account</h2>
            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <p>Please enter your account info to confirm your account deletion:</p>
                <input type="hidden" id="deleteAccountRequest" name="deleteAccountRequest">
                Email: <input type="text" name="email">
                Username: <input type="text" name="username">
                Password: <input type="text" name="password">

                <input type="submit" value="Delete My Account" name="deleteSubmit" />
            </form>

            <hr />

            <h2>UPDATE: Update Email</h2>
            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="updateEmailRequest" name="updateEmailRequest">
                Old Email: <input type="text" name="old_email">
                New Email: <input type="text" name="new_email">
                Password: <input type="text" name="password">

                <input type="submit" value="Update My Email" name="updateSubmit" />
            </form>

            <hr />

            <h2>SELECT: Select Forums by Topic</h2>
            <form method="GET" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="selectRequest" name="selectRequest">

                <label for="interest-select">Filter Forums by Topic:</label>

                <select name="interest" id="interest-select">
                    <option value="">Choose an Option</option>
                    <option value="stocks">Stocks</option>
                    <option value="tech">Tech</option>
                    <option value="sports">Sports</option>
                    <option value="politics">Politics</option>
                    <option value="politics">Nature</option>
                </select>

                <input type="submit" value="Show Forums" name="selectForums" />
            </form>

            <hr />

            <h2>SELECT: Search Post by Content</h2>
            <form method="GET" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="selectPostRequest" name="selectPostRequest">
                Keyword: <input type="text" name="keyword">

                <input type="submit" value="Find Posts" name="selectPosts" />
            </form>

            <hr />

            <h2>PROJECT: Users' Birthday, Favourite Color, and Another Attribute</h2>
            <form method="GET" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="projectRequest" name="projectRequest">

                <select name="attribute" id="attribute-select">
                    <option value="">Choose an Option</option>
                    <option value="top_interest">Top Interest</option>
                    <option value="dateCreated">Date Joined</option>
                    <option value="country">Country</option>
                </select>

                <input type="submit" value="Search" name="projectAttributes" />
            </form>

            <hr />

            <h2>JOIN: IDs of Subscribers in a Livestream </h2>
            <form method="GET" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="joinRequest" name="joinRequest">
                Livestream ID: <input type="number" name="liveID">

                <input type="submit" value="Find" name="joinSubscribers" />
            </form>

            <hr />

            <h2>AGGREGATE: Find Users with Most Posts/Followers/Following</h2>
            <form method="GET" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="aggRequest" name="aggRequest">

                <label for="category-select">Select:</label>

                <select name="categories" id="category-select">
                    <option value="">Choose an Option</option>
                    <option value="posts">Posts</option>
                    <option value="followers">Followers</option>
                    <option value="following">Following</option>
                </select>

                <input type="submit" value="Find" name="aggMax" />
            </form>

            <hr />

            <h2>NESTED AGGREGATION: Average Number of Users Per Country</h2>

            <form method="GET" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="nestedAggRequest" name="nestedAggRequest">
                <input type="submit" value="See Average" name="nestedAggAverage" />
            </form>

            <hr />

            <h2>DIVISION: Users Who ____</h2>
            <form method="GET" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="divisionRequest" name="divisionRequest">

                <select name="user-prop" id="user-prop-select">
                    <option value="">Choose an Option</option>
                    <option value="sub">Have all the Subscriptions</option>
                    <option value="chat">Are in All the Chats</option>
                    <option value="forum">Are in All the Forums</option>
                </select>

                <input type="submit" value="Show Users" name="subDivision" />

            </form>
        </div>


        <div style="width: 40%; display: flex; justify-content: center;">
            <?php
            //this tells the system that it's no longer just parsing html; it's now parsing PHP

            $success = True; //keep track of errors so it redirects the page only if there are no errors
            $db_conn = NULL; // edit the login credentials in connectToDB()
            $show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())

            function debugAlertMessage($message)
            {
                global $show_debug_alert_messages;

                if ($show_debug_alert_messages) {
                    echo "<script type='text/javascript'>alert('" . $message . "');</script>";
                }
            }

            function executePlainSQL($cmdstr)
            { //takes a plain (no bound variables) SQL command and executes it
                //echo "<br>running ".$cmdstr."<br>";
                global $db_conn, $success;

                $statement = OCIParse($db_conn, $cmdstr);
                //There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

                if (!$statement) {
                    echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                    $e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
                    echo htmlentities($e['message']);
                    $success = False;
                }

                $r = OCIExecute($statement, OCI_DEFAULT);
                if (!$r) {
                    echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                    $e = oci_error($statement); // For OCIExecute errors pass the statementhandle
                    echo htmlentities($e['message']);
                    $success = False;
                }

                return $statement;
            }

            function executeBoundSQL($cmdstr, $list)
            {
                /* Sometimes the same statement will be executed several times with different values for the variables involved in the query.
      In this case you don't need to create the statement several times. Bound variables cause a statement to only be
      parsed once and you can reuse the statement. This is also very useful in protecting against SQL injection.
      See the sample code below for how this function is used */

                global $db_conn, $success;
                $statement = OCIParse($db_conn, $cmdstr);

                if (!$statement) {
                    echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                    $e = OCI_Error($db_conn);
                    echo htmlentities($e['message']);
                    $success = False;
                }

                foreach ($list as $tuple) {
                    foreach ($tuple as $bind => $val) {
                        //echo $val;
                        //echo "<br>".$bind."<br>";
                        OCIBindByName($statement, $bind, $val);
                        unset($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
                    }

                    $r = OCIExecute($statement, OCI_DEFAULT);
                    if (!$r) {
                        echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                        $e = OCI_Error($statement); // For OCIExecute errors, pass the statementhandle
                        echo htmlentities($e['message']);
                        echo "<br>";
                        $success = False;
                    }
                }
            }

            function printForums($result)
            { //prints results from a select statement
                echo "<div style='display:flex; flex-direction: column;'>";
                echo "<br>Forum Matching the Topic<br>";
                echo "<table>";
                echo "<tr><th>Forum ID</th><th>Forum Name</th></tr>";

                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    echo "<tr><td>" . $row["FORUMID"] . "</td><td>" . $row["NAME"] . "</td></tr>"; //or just use "echo $row[0]"
                }

                echo "</table></div>";
            }

            function printPosts($result)
            { //prints results from a select statement
                echo "<div style='display:flex; flex-direction: column;'>";
                echo "<br>Post Matching the Content<br>";
                echo "<table>";
                echo "<tr><th>Forum ID</th><th>Post ID</th><th>Post Body</th></tr>";

                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    echo "<tr><td>" . $row["FORUMID"] . "</td><td>" . $row["POSTID"] . "</td><td>" . $row["BODY"] . "</td></tr>"; //or just use "echo $row[0]"
                }

                echo "</table></div>";
            }

            function printAttributes($result, $attribute)
            { //prints results from a select statement
                echo "<div style='display:flex; flex-direction: column;'>";
                echo "<br>Users' Birthday, Favourite Color, Top Interest, and Country<br>";
                echo "<table>";
                echo "<tr><th>Birthday</th><th>Favourite Color</th><th>" . $attribute . "</th></tr>";

                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td><td>" . $row[2] . "</td></tr>"; //or just use "echo $row[0]"
                }

                echo "</table></div>";
            }

            function connectToDB()
            {
                global $db_conn;

                // Your username is ora_(CWL_ID) and the password is a(student number). For example,
                // ora_platypus is the username and a12345678 is the password.
                $db_conn = OCILogon("ora_lankun", "a13649355", "dbhost.students.cs.ubc.ca:1522/stu");

                if ($db_conn) {
                    debugAlertMessage("Database is Connected");
                    return true;
                } else {
                    debugAlertMessage("Cannot connect to Database");
                    $e = OCI_Error(); // For OCILogon errors pass no handle
                    echo htmlentities($e['message']);
                    return false;
                }
            }

            function disconnectFromDB()
            {
                global $db_conn;

                debugAlertMessage("Disconnect from Database");
                OCILogoff($db_conn);
            }

            function handleInsertRequest()
            {
                global $db_conn;

                //Getting the values from user and insert data into the table
                $tuple = array(
                    ":bind1" => $_POST['accountID'],
                    ":bind2" => $_POST['email'],
                    ":bind3" => $_POST['username'],
                    ":bind4" => $_POST['password'],
                    ":bind5" => $_POST['dateCreated'],
                    ":bind6" => $_POST['birthday'],
                    ":bind7" => $_POST['country'],
                    ":bind8" => $_POST['name'],
                    ":bind9" => $_POST['color'],
                    ":bind10" => $_POST['top_interest']
                );

                $alltuples = array(
                    $tuple
                );

                executeBoundSQL("INSERT INTO account (accountID, email, username, password, dateCreated, birthday, country, name, color, top_interest) VALUES (:bind1, :bind2, :bind3, :bind4, TO_DATE(:bind5, 'YYYY-MM-DD'), TO_DATE(:bind6, 'YYYY-MM-DD'), :bind7, :bind8, :bind9, :bind10)", $alltuples);
                OCICommit($db_conn);
            }

            function handleDeleteRequest()
            {
                //TODO
                global $db_conn;

                $email = $_POST['email'];
                $username = $_POST['username'];
                $password = $_POST['password'];

                $query = "SELECT * FROM account WHERE email='" . $email . "' AND password='" . $password . "' AND username='" . $username . "'";
                $result = executePlainSQL($query);

                if (oci_fetch_row($result) != false) {
                    executePlainSQL("DELETE FROM account WHERE email='" . $email . "'");
                    OCICommit($db_conn);
                }
            }

            function handleUpdateRequest()
            {
                global $db_conn;
                $password = $_POST['password'];
                $old_email = $_POST['old_email'];
                $new_email = $_POST['new_email'];

                $query = "SELECT * FROM account WHERE email='" . $old_email . "' AND password='" . $password . "'";
                $result = executePlainSQL($query);

                if (oci_fetch_row($result) != false) {
                    // you need the wrap the old name and new name values with single quotations
                    executePlainSQL("UPDATE account SET email='" . $new_email . "' WHERE email='" . $old_email . "'");
                    OCICommit($db_conn);
                }
            }

            function handleSelectForumsRequest()
            {
                $topic = $_GET['interest'];

                $query = "SELECT FORUMID, NAME FROM Forum WHERE topic='" . $topic . "'";
                $result = executePlainSQL($query);
                printForums($result);
            }

            function handleSelectPostsRequest()
            {
                $word = "'%" . $_GET['keyword'] . "%'";

                $query = "SELECT * FROM contains_posts WHERE body LIKE " . $word;
                $result = executePlainSQL($query);
                printPosts($result);
            }

            function handleProjectRequest()
            {
                $attribute = $_GET['attribute'];

                $query = "SELECT DISTINCT birthday, color, " . $attribute . " FROM Account";
                $result = executePlainSQL($query);
                printAttributes($result, $attribute);
            }

            function handleJoinRequest()
            {
                $id = $_GET['liveID'];

                $query = "SELECT Count(*) FROM Streams_To, Subscriber WHERE Streams_To.userID = Subscriber.userID AND Streams_To.sessionID =" . $id;
                $result = executePlainSQL($query);

                echo "<br>These are the Subscribers:</br>";
                while (($row = oci_fetch_array($result)) != false) {
                    echo "<br>" . $row[0] . "</br>";
                }
            }

            function handleAggRequest()
            {
                $type = $_GET['categories'];

                $max_quantity = "(SELECT MAX(" . $type . ") FROM account)";

                $query = "SELECT username FROM account WHERE " . $type . "=" . $max_quantity;
                $result = executePlainSQL($query);

                $max_query = "SELECT MAX(" . $type . ") FROM account";
                $value = executePlainSQL($max_query);

                if (($row = oci_fetch_row($value)) != false) {
                    echo "<br>These are the people with max number (at " . $row[0] . ") of " . $type . ":</br>";
                }

                while (($row = oci_fetch_array($result)) != false) {
                    echo "<br>" . $row[0] . "</br>";
                }
            }

            function handleNestedAggRequest()
            {
                $inner_query = "SELECT COUNT(*) AS count FROM account GROUP BY country";
                $query = "SELECT ROUND(AVG(count), 2) FROM ($inner_query)";
                $result = executePlainSQL($query);

                if (($row = oci_fetch_row($result)) != false) {
                    echo "<br>Average number of users per country is: " . $row[0] . "";
                }
            }

            function handleDivisionRequest()
            {
                $type = $_GET['user-prop'];

                $all_query = "SELECT subID FROM Subscription";
                $user_query = "SELECT subID FROM Owns_Subscriptions WHERE Owns_Subscriptions.accountID = account.accountID";

                if ($type == 'chat') {
                    $all_query = "SELECT chatID FROM Chat";
                    $user_query = "SELECT chatID FROM Participates_In WHERE Participates_In.accountID = account.accountID";
                } else if ($type == 'forum') {
                    $all_query = "SELECT forumID FROM Forum";
                    $user_query = "SELECT forumID FROM Member_Of WHERE Member_Of.accountID = account.accountID";
                }

                $query = "SELECT username FROM account WHERE NOT EXISTS ((" . $all_query . ") MINUS (" . $user_query . "))";
                $result = executePlainSQL($query);

                echo "<br>These are users: </br>";

                while (($row = oci_fetch_array($result)) != false) {
                    echo "<br>" . $row[0] . "</br>";
                }
            }

            // HANDLE ALL POST ROUTES
            // A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
            function handlePOSTRequest()
            {
                if (connectToDB()) {
                    if (array_key_exists('createAccountRequest', $_POST)) {
                        handleInsertRequest();
                    } else if (array_key_exists('deleteAccountRequest', $_POST)) {
                        handleDeleteRequest();
                    } else if (array_key_exists('updateEmailRequest', $_POST)) {
                        handleUpdateRequest();
                    }

                    disconnectFromDB();
                }
            }

            // HANDLE ALL GET ROUTES
            // A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
            function handleGETRequest()
            {
                if (connectToDB()) {
                    if (array_key_exists('selectForums', $_GET)) {
                        handleSelectForumsRequest();
                    } else if (array_key_exists('selectPosts', $_GET)) {
                        handleSelectPostsRequest();
                    } else if (array_key_exists('projectAttributes', $_GET)) {
                        handleProjectRequest();
                    } else if (array_key_exists('joinSubscribers', $_GET)) {
                        handleJoinRequest();
                    } else if (array_key_exists('aggMax', $_GET)) {
                        handleAggRequest();
                    } else if (array_key_exists('nestedAggAverage', $_GET)) {
                        handleNestedAggRequest();
                    } else if (array_key_exists('subDivision', $_GET)) {
                        handleDivisionRequest();
                    }

                    disconnectFromDB();
                }
            }

            if (isset($_POST['insertSubmit']) || isset($_POST['deleteSubmit']) || isset($_POST['updateSubmit'])) {
                handlePOSTRequest();
            } else if (
                isset($_GET['selectRequest']) || isset($_GET['selectPostRequest']) || isset($_GET['projectRequest'])
                || isset($_GET['joinRequest']) || isset($_GET['aggRequest']) || isset($_GET['nestedAggRequest']) || isset($_GET['divisionRequest'])
            ) {
                handleGETRequest();
            }
            ?>
        </div>

</body>

</html>