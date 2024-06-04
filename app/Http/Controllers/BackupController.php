<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BackupController extends Controller
{
    public function download()
    {
        $dbhost = config('database.connections.mysql.host');
        $dbport = config('database.connections.mysql.port');
        $dbname = config('database.connections.mysql.database');
        $dbuser = config('database.connections.mysql.username');
        $dbpass = config('database.connections.mysql.password');
        //save file
        $file_name = $dbname . '_' . date("d_m_Y_H_i_s") . '.sql';
        $path_mysqldump = "C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin";
        $dbfile = public_path() . "/backups/" . $file_name;

        $mysqldump = $path_mysqldump . "\mysqldump";
        if ($path_mysqldump == "") {
            $mysqldump = "mysqldump";
        }
        $command = "$mysqldump --routines -u$dbuser $dbname > $dbfile";
        if ($dbpass != "") {
            $command = "$mysqldump --routines -u$dbuser -p$dbpass $dbname > $dbfile";
        }
        exec($command, $output, $worked);
        // switch ($worked) {
        //     case 0:
        //         echo 'La base de datos <b>' . $dbname . '</b> se ha almacenado correctamente en la siguiente ruta ' . getcwd() . '/' . $dbfile . '</b>';
        //         break;
        //     case 1:
        //         echo 'Se ha producido un error al exportar <b>' . $dbname . '</b> a ' . getcwd() . '/' . $dbfile . '</b>';
        //         break;
        //     case 2:
        //         echo 'Se ha producido un error de exportación, compruebe la siguiente información: <br/><br/><table><tr><td>Nombre de la base de datos:</td><td><b>' . $dbname . '</b></td></tr><tr><td>Nombre de usuario MySQL:</td><td><b>' . $dbuser . '</b></td></tr><tr><td>Contraseña MySQL:</td><td><b>NOTSHOWN</b></td></tr><tr><td>Nombre de host MySQL:</td><td><b>' . $dbhost . '</b></td></tr></table>';
        //         break;
        // }

        if ($worked == 0) {
            return response()->JSON(["url" => asset('backups/' . $file_name)]);
        }
        return response()->JSON(["sw" => false]);
    }
}
