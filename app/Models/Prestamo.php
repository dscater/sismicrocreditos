<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prestamo extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "cliente_id",
        "tipo",
        "grupo_id",
        "monto",
        "plazo",
        "f_ci",
        "f_luz",
        "f_agua",
        "croquis",
        "documento_1",
        "documento_2",
        "documento_3",
        "documento_4",
        "estado",
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function grupo()
    {
        return $this->belongsTo(Grupo::class, 'grupo_id');
    }
}
