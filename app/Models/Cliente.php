<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    use HasFactory;

    protected $fllable = [
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
    ];
}
