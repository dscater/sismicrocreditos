<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Schema;

class HistorialAccion extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id", "accion", "descripcion", "datos_original", "datos_nuevo", "modulo", "fecha", "hora",
    ];

    protected $appends = ["fecha_hora_t", "fecha_t"];

    public function getFechaHoraTAttribute()
    {
        return date("d/m/Y H:i", strtotime($this->fecha . ' ' . $this->hora));
    }

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public static function getDetalleRegistro($item, $table)
    {
        $columns = Schema::getColumnListing($table);
        $datos = "";
        foreach ($columns as $key => $col) {
            $datos .= $col . ": " . $item[$col];
            if ($key < count($columns)) {
                $datos .= '<br/>';
            }
        }
        return $datos;
    }
}
