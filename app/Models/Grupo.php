<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grupo extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "nombre",
        "integrantes",
        "monto",
        "plazo",
        "desembolso",
        "estado",
        "fecha_registro"
    ];

    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d-m-Y", strtotime($this->fecha_registro));
    }

    public function prestamos()
    {
        return $this->hasMany(Prestamo::class, 'grupo_id');
    }

    public function grupo_plan_pagos()
    {
        return $this->hasMany(GrupoPlanPago::class, 'grupo_id');
    }

    public function grupo_pagos()
    {
        return $this->hasMany(GrupoPago::class, 'grupo_id');
    }
}
