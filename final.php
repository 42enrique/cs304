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
            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="selectRequest" name="selectRequest">

                <label for="interest-select">Filter Forums by Topic:</label>

                <select name="interest" id="interest-select">
                    <option value="">Choose an Option</option>
                    <option value="stocks">Stocks</option>
                    <option value="tech">Tech</option>
                    <option value="sports">Sports</option>
                    <option value="politics">Politics</option>
                </select>

                <input type="submit" value="Show Forums" name="selectSubmit" />
            </form>

            <hr />

            <h2>SELECT: Search Post by Content</h2>
            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="selectPostRequest" name="selectPostRequest">
                Keyword: <input type="text" name="keyword">

                <input type="submit" value="Find Posts" name="selectPostSubmit" />
            </form>

            <hr />

            <h2>PROJECT: Users' Birthday, Favourite Color, and Top Interest by Country</h2>
            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="projectRequest" name="projectRequest">

                Target Country: <input type="text" name="country">

                <input type="submit" value="Search" name="projectSubmit" />
            </form>

            <hr />

            <h2>JOIN: IDs of Subscribers in a Livestream </h2>
            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="joinRequest" name="joinRequest">
                Livestream ID: <input type="number" name="liveID">

                <input type="submit" value="Find" name="joinSubmit" />
            </form>

            <hr />

            <h2>AGGREGATE (& JOIN): Select Users with Most X</h2>
            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="aggRequest" name="aggRequest">

                <label for="category-select">Select:</label>

                <select name="categories" id="category-select">
                    <option value="">Choose an Option</option>
                    <option value="posts">Posts</option>
                    <option value="messages">Messages</option>
                    <option value="livestreams">Livestreams</option>
                    <option value="pictures">Pictures</option>
                </select>

                <input type="submit" value="Find" name="aggSubmit" />
            </form>

            <hr />

            <h2>NESTED AGGREGATION: Average Number of X Per Users</h2>

            <form method="POST" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="nestedAggSubmit" name="nestedAggSubmit">
                <label for="nested-category-select">Select:</label>

                <select name="categories" id="nested-category-select">
                    <option value="">Choose an Option</option>
                    <option value="posts">Posts</option>
                    <option value="messages">Messages</option>
                    <option value="livestreams">Livestreams</option>
                    <option value="pictures">Pictures</option>
                </select>

                <input type="submit" value="See Average" name="nestedAggSubmit" />
            </form>

            <hr />

            <h2>DIVISION: Users Who Has All the Subscription Services</h2>
            <form method="GET" action="final.php">
                <!--refresh page when submitted-->
                <input type="hidden" id="allSubRequest" name="allSubRequest">
                <input type="submit" name="Show Users" />

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

            function printByCountry($result)
            { //prints results from a select statement
                echo "<div style='display:flex; flex-direction: column;'>";
                echo "<br>Results by Target Country<br>";
                echo "<table>";
                echo "<tr><th>Birthday</th><th>Favourite Color</th><th>Top Interest</th></tr>";

                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    echo "<tr><td>" . $row["BIRTHDAY"] . "</td><td>" . $row["COLOR"] . "</td><td>" . $row["TOP_INTEREST"] . "</td></tr>"; //or just use "echo $row[0]"
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
                } else {
                    echo "<br> There was an error updating your email, please double check your email and password <br>";
                }
            }

            function handleResetRequest()
            {
                global $db_conn;
                // Drop old table
                executePlainSQL("DROP TABLE demoTable");

                // Create new table
                echo "<br> creating new table <br>";
                executePlainSQL("CREATE TABLE demoTable (id int PRIMARY KEY, name char(30))");
                OCICommit($db_conn);
            }

            function handleInsertRequest()
            {
                global $db_conn;

                //Getting the values from user and insert data into the table
                $tuple = array(
                    ":bind1" => $_POST['insNo'],
                    ":bind2" => $_POST['insName']
                );

                $alltuples = array(
                    $tuple
                );

                executeBoundSQL("insert into demoTable values (:bind1, :bind2)", $alltuples);
                OCICommit($db_conn);
            }

            function handleCountRequest()
            {
                global $db_conn;

                $result = executePlainSQL("SELECT Count(*) FROM demoTable");

                if (($row = oci_fetch_row($result)) != false) {
                    echo "<br> The number of tuples in demoTable: " . $row[0] . "<br>";
                }
            }

            // HANDLE ALL POST ROUTES
            // A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
            function handlePOSTRequest()
            {
                if (connectToDB()) {
                    if (array_key_exists('resetTablesRequest', $_POST)) {
                        handleResetRequest();
                    } else if (array_key_exists('updateQueryRequest', $_POST)) {
                        handleUpdateRequest();
                    } else if (array_key_exists('insertQueryRequest', $_POST)) {
                        handleInsertRequest();
                    }

                    disconnectFromDB();
                }
            }

            // HANDLE ALL GET ROUTES
            // A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
            function handleGETRequest()
            {
                if (connectToDB()) {
                    if (array_key_exists('countTuples', $_GET)) {
                        handleCountRequest();
                    }

                    disconnectFromDB();
                }
            }

            if (isset($_POST['reset']) || isset($_POST['updateSubmit']) || isset($_POST['insertSubmit'])) {
                handlePOSTRequest();
            } else if (isset($_GET['countTupleRequest'])) {
                handleGETRequest();
            }
            ?>
        </div>

</body>

</html>