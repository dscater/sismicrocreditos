<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Desembolso extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "tipo_prestamo",
        "prestamo_id",
        "grupo_id",
        "monto",
        "cancelado",
        "fecha_registro",
    ];

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
