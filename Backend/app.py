from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector  # type: ignore
from mysql.connector import Error  # type: ignore

app = Flask(__name__)
CORS(app)

# If your imported database name is Sportsdb instead of SportsDB_2,
# change only this one line.
db_config = {
    "host": "localhost",
    "user": "root",
    "password": "Hanuman$9",
    "database": "Sportsdb"
}


def get_connection():
    return mysql.connector.connect(**db_config)


def format_date_fields(rows, fields):
    if isinstance(rows, dict):
        rows = [rows]

    for row in rows:
        if row:
            for field in fields:
                if row.get(field):
                    try:
                        row[field] = row[field].isoformat()
                    except AttributeError:
                        pass
    return rows


@app.route("/api/health", methods=["GET"])
def health():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT DATABASE()")
        db_name = cursor.fetchone()[0]
        return jsonify({"status": "ok", "database": db_name})
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database connection failed"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# PLAYERS
# -----------------------------
@app.route("/api/players", methods=["GET"])
def get_players():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT PlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored
            FROM PlayerInfo
            ORDER BY PlayerID DESC
        """
        cursor.execute(query)
        players = cursor.fetchall()
        format_date_fields(players, ["DOB"])
        return jsonify(players)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/players/<int:player_id>", methods=["GET"])
def get_player(player_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT PlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored
            FROM PlayerInfo
            WHERE PlayerID = %s
        """
        cursor.execute(query, (player_id,))
        player = cursor.fetchone()
        if player:
            format_date_fields(player, ["DOB"])
            return jsonify(player)
        return jsonify({"error": "Player not found"}), 404
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# TEAMS
# -----------------------------
@app.route("/api/teams", methods=["GET"])
def get_teams():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                T.TeamID,
                T.TeamName,
                T.Country,
                T.NumOfMatchesPlayed,
                T.MatchesWon,
                T.MatchesLost,
                T.MatchesTie,
                T.TotalGoalsScored,
                T.ManagerID,
                CONCAT(U.UserFirstName, ' ', COALESCE(U.UserLastName, '')) AS ManagerName
            FROM TeamInfo T
            LEFT JOIN Users U ON T.ManagerID = U.UserID
            ORDER BY T.TeamID
        """
        cursor.execute(query)
        teams = cursor.fetchall()
        return jsonify(teams)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/teams/<int:team_id>", methods=["GET"])
def get_team(team_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                T.TeamID,
                T.TeamName,
                T.Country,
                T.NumOfMatchesPlayed,
                T.MatchesWon,
                T.MatchesLost,
                T.MatchesTie,
                T.TotalGoalsScored,
                T.ManagerID,
                CONCAT(U.UserFirstName, ' ', COALESCE(U.UserLastName, '')) AS ManagerName
            FROM TeamInfo T
            LEFT JOIN Users U ON T.ManagerID = U.UserID
            WHERE T.TeamID = %s
        """
        cursor.execute(query, (team_id,))
        team = cursor.fetchone()
        if team:
            return jsonify(team)
        return jsonify({"error": "Team not found"}), 404
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# MATCHES
# -----------------------------
@app.route("/api/matches", methods=["GET"])
def get_matches():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT MatchID, MatchName, Venue, MatchDate
            FROM MatchInfo
            ORDER BY MatchDate DESC, MatchID DESC
        """
        cursor.execute(query)
        matches = cursor.fetchall()
        format_date_fields(matches, ["MatchDate"])
        return jsonify(matches)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/matches/<int:match_id>", methods=["GET"])
def get_match(match_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT MatchID, MatchName, Venue, MatchDate
            FROM MatchInfo
            WHERE MatchID = %s
        """
        cursor.execute(query, (match_id,))
        match = cursor.fetchone()
        if match:
            format_date_fields(match, ["MatchDate"])
            return jsonify(match)
        return jsonify({"error": "Match not found"}), 404
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# USERS
# -----------------------------
@app.route("/api/users", methods=["GET"])
def get_users():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                UserID,
                UserName,
                UserFirstName,
                UserLastName,
                UserRole,
                Email,
                Mobile
            FROM Users
            ORDER BY UserID
        """
        cursor.execute(query)
        users = cursor.fetchall()
        return jsonify(users)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/users/<int:user_id>", methods=["GET"])
def get_user(user_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                UserID,
                UserName,
                UserFirstName,
                UserLastName,
                UserRole,
                Email,
                Mobile
            FROM Users
            WHERE UserID = %s
        """
        cursor.execute(query, (user_id,))
        user = cursor.fetchone()
        if user:
            return jsonify(user)
        return jsonify({"error": "User not found"}), 404
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# TEAM PLAYERS
# -----------------------------
@app.route("/api/team-players", methods=["GET"])
def get_team_players():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                TP.ID,
                TP.TeamID,
                T.TeamName,
                TP.PlayerID,
                P.PlayerName
            FROM TeamPlayers TP
            JOIN TeamInfo T ON TP.TeamID = T.TeamID
            JOIN PlayerInfo P ON TP.PlayerID = P.PlayerID
            ORDER BY TP.ID
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/team-players/<int:team_id>", methods=["GET"])
def get_players_by_team(team_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                P.PlayerID,
                P.PlayerName,
                P.Age,
                P.DOB,
                P.Gender,
                P.TotalGoalsScored
            FROM TeamPlayers TP
            JOIN PlayerInfo P ON TP.PlayerID = P.PlayerID
            WHERE TP.TeamID = %s
            ORDER BY P.PlayerName
        """
        cursor.execute(query, (team_id,))
        players = cursor.fetchall()
        format_date_fields(players, ["DOB"])
        return jsonify(players)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# MATCH HISTORY
# -----------------------------
@app.route("/api/match-history", methods=["GET"])
def get_all_match_history():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                MH.ID,
                MH.MatchID,
                MI.MatchName,
                MH.TeamID,
                T1.TeamName AS TeamName,
                MH.PlayedAgainst,
                T2.TeamName AS PlayedAgainstName,
                MH.MatchResult
            FROM MatchHistory MH
            JOIN MatchInfo MI ON MH.MatchID = MI.MatchID
            JOIN TeamInfo T1 ON MH.TeamID = T1.TeamID
            JOIN TeamInfo T2 ON MH.PlayedAgainst = T2.TeamID
            ORDER BY MH.ID DESC
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/match-history/<int:match_id>", methods=["GET"])
def get_match_history(match_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                MH.ID,
                MH.MatchID,
                MH.TeamID,
                T1.TeamName AS TeamName,
                MH.PlayedAgainst,
                T2.TeamName AS PlayedAgainstName,
                MH.MatchResult
            FROM MatchHistory MH
            JOIN TeamInfo T1 ON MH.TeamID = T1.TeamID
            JOIN TeamInfo T2 ON MH.PlayedAgainst = T2.TeamID
            WHERE MH.MatchID = %s
            ORDER BY MH.ID
        """
        cursor.execute(query, (match_id,))
        rows = cursor.fetchall()
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# PLAYER HISTORY
# -----------------------------
@app.route("/api/player-history", methods=["GET"])
def get_all_player_history():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                PH.ID,
                PH.PlayerID,
                P.PlayerName,
                PH.MatchID,
                MI.MatchName,
                PH.TeamID,
                T1.TeamName AS TeamName,
                PH.PlayedAgainst,
                T2.TeamName AS PlayedAgainstName,
                PH.MatchDate,
                PH.MatchResult,
                PH.GoalsScored
            FROM PlayerHistory PH
            JOIN PlayerInfo P ON PH.PlayerID = P.PlayerID
            JOIN MatchInfo MI ON PH.MatchID = MI.MatchID
            JOIN TeamInfo T1 ON PH.TeamID = T1.TeamID
            JOIN TeamInfo T2 ON PH.PlayedAgainst = T2.TeamID
            ORDER BY PH.MatchDate DESC, PH.ID DESC
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        format_date_fields(rows, ["MatchDate"])
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/player-history/<int:player_id>", methods=["GET"])
def get_player_history(player_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                PH.ID,
                PH.PlayerID,
                P.PlayerName,
                PH.MatchID,
                MI.MatchName,
                PH.TeamID,
                T1.TeamName AS TeamName,
                PH.PlayedAgainst,
                T2.TeamName AS PlayedAgainstName,
                PH.MatchDate,
                PH.MatchResult,
                PH.GoalsScored
            FROM PlayerHistory PH
            JOIN PlayerInfo P ON PH.PlayerID = P.PlayerID
            JOIN MatchInfo MI ON PH.MatchID = MI.MatchID
            JOIN TeamInfo T1 ON PH.TeamID = T1.TeamID
            JOIN TeamInfo T2 ON PH.PlayedAgainst = T2.TeamID
            WHERE PH.PlayerID = %s
            ORDER BY PH.MatchDate DESC, PH.ID DESC
        """
        cursor.execute(query, (player_id,))
        rows = cursor.fetchall()
        format_date_fields(rows, ["MatchDate"])
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# TEAM HISTORY
# -----------------------------
@app.route("/api/team-history", methods=["GET"])
def get_all_team_history():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                TH.ID,
                TH.MatchID,
                MI.MatchName,
                TH.TeamID,
                T1.TeamName AS TeamName,
                TH.PlayedAgainst,
                T2.TeamName AS PlayedAgainstName,
                TH.MatchDate,
                TH.MatchResult,
                TH.GoalsScored
            FROM TeamHistory TH
            JOIN MatchInfo MI ON TH.MatchID = MI.MatchID
            JOIN TeamInfo T1 ON TH.TeamID = T1.TeamID
            JOIN TeamInfo T2 ON TH.PlayedAgainst = T2.TeamID
            ORDER BY TH.MatchDate DESC, TH.ID DESC
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        format_date_fields(rows, ["MatchDate"])
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/team-history/<int:team_id>", methods=["GET"])
def get_team_history(team_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                TH.ID,
                TH.MatchID,
                MI.MatchName,
                TH.TeamID,
                T1.TeamName AS TeamName,
                TH.PlayedAgainst,
                T2.TeamName AS PlayedAgainstName,
                TH.MatchDate,
                TH.MatchResult,
                TH.GoalsScored
            FROM TeamHistory TH
            JOIN MatchInfo MI ON TH.MatchID = MI.MatchID
            JOIN TeamInfo T1 ON TH.TeamID = T1.TeamID
            JOIN TeamInfo T2 ON TH.PlayedAgainst = T2.TeamID
            WHERE TH.TeamID = %s
            ORDER BY TH.MatchDate DESC, TH.ID DESC
        """
        cursor.execute(query, (team_id,))
        rows = cursor.fetchall()
        format_date_fields(rows, ["MatchDate"])
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# PLAYER AWARDS
# -----------------------------
@app.route("/api/player-awards", methods=["GET"])
def get_player_awards():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                PA.ID,
                PA.MatchID,
                MI.MatchName,
                PA.PlayerID,
                P.PlayerName,
                PA.TeamID,
                T.TeamName,
                PA.AwardName,
                PA.DateofAward
            FROM PlayerAwards PA
            LEFT JOIN MatchInfo MI ON PA.MatchID = MI.MatchID
            LEFT JOIN PlayerInfo P ON PA.PlayerID = P.PlayerID
            LEFT JOIN TeamInfo T ON PA.TeamID = T.TeamID
            ORDER BY PA.DateofAward DESC, PA.ID DESC
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        format_date_fields(rows, ["DateofAward"])
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/player-awards/<int:player_id>", methods=["GET"])
def get_awards_by_player(player_id):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                PA.ID,
                PA.AwardName,
                PA.DateofAward,
                MI.MatchName,
                T.TeamName
            FROM PlayerAwards PA
            LEFT JOIN MatchInfo MI ON PA.MatchID = MI.MatchID
            LEFT JOIN TeamInfo T ON PA.TeamID = T.TeamID
            WHERE PA.PlayerID = %s
            ORDER BY PA.DateofAward DESC, PA.ID DESC
        """
        cursor.execute(query, (player_id,))
        rows = cursor.fetchall()
        format_date_fields(rows, ["DateofAward"])
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# TEAM AWARDS
# -----------------------------
@app.route("/api/team-awards", methods=["GET"])
def get_team_awards():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                TA.ID,
                TA.TeamID,
                T.TeamName,
                TA.MatchID,
                MI.MatchName,
                TA.PlayerID,
                P.PlayerName,
                TA.AwardName,
                TA.DateofAward
            FROM TeamAwards TA
            LEFT JOIN TeamInfo T ON TA.TeamID = T.TeamID
            LEFT JOIN MatchInfo MI ON TA.MatchID = MI.MatchID
            LEFT JOIN PlayerInfo P ON TA.PlayerID = P.PlayerID
            ORDER BY TA.DateofAward DESC, TA.ID DESC
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        format_date_fields(rows, ["DateofAward"])
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# STAGE_WC_MATCHES
# -----------------------------
@app.route("/api/stage-wc-matches", methods=["GET"])
def get_stage_wc_matches():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                home_team,
                away_team,
                home_score,
                away_score,
                year,
                hosts,
                stadium,
                match_date,
                home_xg,
                away_xg,
                Round,
                Score,
                Referee
            FROM Stage_WC_Matches
            ORDER BY year DESC, match_date DESC
        """
        cursor.execute(query)
        matches = cursor.fetchall()
        return jsonify(matches)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/stage-wc-matches/<int:year>", methods=["GET"])
def get_stage_wc_matches_by_year(year):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                home_team,
                away_team,
                home_score,
                away_score,
                year,
                hosts,
                stadium,
                match_date,
                home_xg,
                away_xg,
                Round,
                Score,
                Referee
            FROM Stage_WC_Matches
            WHERE year = %s
            ORDER BY match_date
        """
        cursor.execute(query, (year,))
        matches = cursor.fetchall()
        return jsonify(matches)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# -----------------------------
# SUMMARY ENDPOINTS
# -----------------------------
@app.route("/api/summary/table-counts", methods=["GET"])
def get_table_counts():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT 'Users' AS TableName, COUNT(*) AS RowCount FROM Users
            UNION ALL
            SELECT 'TeamInfo', COUNT(*) FROM TeamInfo
            UNION ALL
            SELECT 'PlayerInfo', COUNT(*) FROM PlayerInfo
            UNION ALL
            SELECT 'MatchInfo', COUNT(*) FROM MatchInfo
            UNION ALL
            SELECT 'MatchHistory', COUNT(*) FROM MatchHistory
            UNION ALL
            SELECT 'TeamPlayers', COUNT(*) FROM TeamPlayers
            UNION ALL
            SELECT 'PlayerHistory', COUNT(*) FROM PlayerHistory
            UNION ALL
            SELECT 'TeamHistory', COUNT(*) FROM TeamHistory
            UNION ALL
            SELECT 'TeamAwards', COUNT(*) FROM TeamAwards
            UNION ALL
            SELECT 'PlayerAwards', COUNT(*) FROM PlayerAwards
            UNION ALL
            SELECT 'Stage_WC_Matches', COUNT(*) FROM Stage_WC_Matches
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/summary/top-players", methods=["GET"])
def get_top_players():
    limit = request.args.get("limit", default=10, type=int)
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT PlayerID, PlayerName, TotalGoalsScored
            FROM PlayerInfo
            ORDER BY TotalGoalsScored DESC, PlayerName ASC
            LIMIT %s
        """
        cursor.execute(query, (limit,))
        rows = cursor.fetchall()
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route("/api/summary/top-teams", methods=["GET"])
def get_top_teams():
    limit = request.args.get("limit", default=10, type=int)
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT
                TeamID,
                TeamName,
                Country,
                NumOfMatchesPlayed,
                MatchesWon,
                MatchesTie,
                MatchesLost,
                TotalGoalsScored
            FROM TeamInfo
            ORDER BY MatchesWon DESC, TotalGoalsScored DESC
            LIMIT %s
        """
        cursor.execute(query, (limit,))
        rows = cursor.fetchall()
        return jsonify(rows)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if "conn" in locals() and conn.is_connected():
            cursor.close()
            conn.close()


if __name__ == "__main__":
    app.run(port=3001, debug=True)





