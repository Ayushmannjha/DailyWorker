<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Search</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;300;400;500&family=Varela+Round&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="profile.css" />
<link rel="stylesheet"
	href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
</head>

<style>
.home {
	display: flex;
	flex-direction: row;
}

.search {
	width: 100%;
	display: flex;
	position: relative;
	display: flex;
	align-items: center;
	justify-content: center;
}
 table {
        border-collapse: collapse;
        width: 100%;
        
        background-color: white;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
        color: #333;
        font-weight: bold;
    }

   

    
.search i {
	position: absolute;
	color: #fff;
	font-size: 2.4rem;
	color: #f74c0d;
	cursor: pointer;
	right: 0;
}

.search input[type=search] {
	width: 100%;
	border: none;
	outline: none;
	padding: 15px 10px;
	border-radius: 10px;
	background-color: #051923;
	color: #fff;
	font-size: 1.3rem;
}

input[type="search"]::-webkit-search-decoration, input[type="search"]::-webkit-search-cancel-button,
	input[type="search"]::-webkit-search-results-button, input[type="search"]::-webkit-search-results-decoration
	{
	-webkit-appearance: none;
}

/* results */
.results{
	
	color: white;
}
table{
	position: absolute;
	top: 72%;
	left: 70%;
	transform: translate(-50% , -50%);
	width: 50%;
	
}



table th {
	background-color: #051923;
	color: #fb5417;
}

td{
	color: #fff;
	background-color: #051923;
}

td form button{
	background:transparent;
	color: #fb5417;
	display: inline-block;
	width: 80px;
	height: 40px;
	border-radius: 8px;
	border: none;
	outline: 1px solid #f74c0d;
	cursor: pointer;
	transition: .3s ease;
	margin: 5px 10px;
}
td form button:hover{
	background-color: #fb5417;
	color: #fff;
}


@media ( max-width :816px) {
	.search input[type=search] {
		width: 100%;
		border: none;
		outline: none;
		padding: 8px 4px;
		border-radius: 10px;
		background-color: #051923;
		color: #fff;
		font-size: 1.3rem;
	}
	.home {
		display: flex;
		flex-direction: column;
	}
	.box {
		padding: 1rem;
	}
	.search {
		width: auto;
		margin-bottom: 50%;
	}
}
</style>
<body>
	<!-- preloader -->
	<div class="preloader">
		<div class="loader"></div>
	</div>
	<!-- preloader
     -->
	<!-- Header start -->
	<header class="header">
		<a href="#" class="logo"><h2>
				Daily<span>Worker</span>
			</h2></a>

		<div class="bx bx-menu" id="menu"></div>

		<ul class="navbar  ">
			<li><a href="./index.html"> <i class='bx bxs-home'></i>Home
			</a></li>
			<li><a href="WorkerLogin.jsp"><i class='bx bxs-briefcase'></i>Find
					Work</a></li>
			<li><a href="Coustmer.jsp"><i class='bx bxs-user'></i>Find
					Worker</a></li>
			<li><a href="#contact"><i class='bx bxs-phone'></i>Contact
					Us</a></li>
		</ul>

	</header>


	<!-- home section starts -->
	<section class="home" id="home">

		<div class="box">
			<h1>
				Search Workers According To <br> Your Location
			</h1>
			<p>Welcome to DailyWorker, your go-to platform for seamlessly
				connecting skilled laborers with potential employers seeking their
				services. Our user-friendly website serves as a dedicated hub where
				employers and laborers can find each other, making the process of
				finding work or hiring workers efficient and hassle-free.</p>

		</div>

		<div class="search">
			<form action="CoustmerLogin.jsp" method="post" class="search">
				<input type="search" name="query" placeholder="Location">
				
					<i class='bx bx-search-alt-2'></i>
				
				
			</form>
		</div>


		</section>
		
		</div>


<!-- ......... -->
<div class="results">
	<%!String phone = "";
				String memail = "";
				String mname = "";	
				String mspec = "";
				String madd = "";
			String result = "";
			%>

		<!-- Display search results -->
		<div class = "table">
		<table>
			<tr>
				<th>Worker ID</th>
				<th>Name</th>
				<th>Specialty</th>
				<th>Address</th>
				<th>Phone</th>
			</tr>
			
			<%
			if (request.getMethod().equalsIgnoreCase("post")) {
				String reteri = request.getParameter("query");
				if (reteri != null) {
					try {
						Class.forName("oracle.jdbc.driver.OracleDriver");
						Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system",
								"manager");
				String query = "SELECT * FROM labourinfo WHERE address LIKE ?";
				PreparedStatement pst = con.prepareStatement(query); // Adding the wildcard % before and after the search string
				pst.setString(1, "%" + reteri + "%");
				ResultSet rs = pst.executeQuery();
				ResultSetMetaData rsm = rs.getMetaData();
				//if(!rs.next()){
					//out.print("<tr><td>No record found</td></tr>");
				//}
				
				while (rs.next()) {
					String workerId = rs.getString(2);
					String workerName = rs.getString(1);
					String workerSpecialty = rs.getString(4);
					String workerAddress = rs.getString(5);
					phone = rs.getString(3);
			%>
			
			<tr>
				<td><%=workerId%></td>
				<td><%=workerName%></td>
				<td><%=workerSpecialty%></td>
				<td><%=workerAddress%></td>
				<td>
					<form action="Account" method="post">
						<input type="hidden" name="phone" value="<%=phone%>">
						<button type="submit" class="call-button"
							onclick="showPopup('<%=phone%>')">Call</button>
					</form>
				</td>
			</tr>
			<%
			}
			pst.close();
			con.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
			}
			}
			%>
		</table>
</div>
<!-- ......... -->



		<script>
        function showPopup(phone) {
            alert("Phone number: " + phone);
        }
    </script>
		<script>
        let menu = document.querySelector('#menu');
let navbar = document.querySelector('.navbar');

menu.onclick = () =>{
    navbar.classList.toggle('responsive');
    menu.classList.toggle('bx-x');
}

window.onscroll = () =>{
    navbar.classList.remove('responsive');
    menu.classList.remove('bx-x');
}

    window.addEventListener("load", function () {
      const preloader = document.querySelector(".preloader");
      preloader.classList.add("preload-finish");
    });

</script>
</body>
</html>