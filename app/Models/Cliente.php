<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "segundo_nombre",
        "paterno",
        "materno",
        "dir",
        "ci",
        "ci_exp",
        "cel",
        "fono",
        "edad",
        "referencia",
        "cel_ref",
        "parentesco",
        "fecha_registro"
    ];

    protected $appends = ['full_name', 'full_ci', "fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function getFullNameAttribute()
    {
        return $this->nombre . ($this->segundo_nombre != NULL && $this->segundo_nombre != '' ? ' ' . $this->segundo_nombre . ' ' : ' ') . $this->paterno . ($this->materno != NULL && $this->materno != '' ? ' ' . $this->materno : '');
    }
    public function getFullCiAttribute()
    {
        return $this->ci . ' ' . $this->ci_exp;
    }

    public function prestamos()
    {
        return $this->hasMany(Prestamo::class, 'cliente_id')->orderBy("id", "asc");
    }
}
