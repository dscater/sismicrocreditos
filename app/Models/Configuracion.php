<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Configuracion extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre_sistema",
        "alias",
        "razon_social",
        "dir",
        "nit",
        "fono",
        "actividad",
        "correo",
        "logo",
    ];

    protected $appends = ['path_image'];
    public function getPathImageAttribute()
    {
        return asset('imgs/' . $this->logo);
    }
}
