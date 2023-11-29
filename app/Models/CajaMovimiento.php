<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CajaMovimiento extends Model
{
    use HasFactory;

    protected $fillable = [
        "caja_id",
        "user_id",
        "monto",
        "tipo",
        "glosa",
        "tipo_prestamo",
        "prestamo_id",
        "grupo_id",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t"];
    
    public function getFechaRegistroTAttribute()
    {
        return date("d-m-Y", strtotime($this->fecha_registro));
    }

    public function caja()
    {
        return $this->belongsTo(Caja::class, 'caja_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function prestamo()
    {
        return $this->belongsTo(Prestamo::class, 'prestamo_id');
    }

    public function grupo()
    {
        return $this->belongsTo(Grupo::class, 'grupo_id');
    }
}
