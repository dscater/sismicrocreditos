<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grupo extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "integrantes",
        "monto",
    ];

    public function prestamos()
    {
        return $this->hasMany(Prestamo::class, 'grupo_id');
    }
}
