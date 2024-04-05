<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grupo extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "user_desembolso_id",
        "user_aprobado_id",
        "nombre",
        "integrantes",
        "monto",
        "plazo",
        "desembolso",
        "fecha_desembolso",
        "estado",
        "finalizado",
        "fecha_aprobado",
        "fecha_rechazado",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "fecha_desembolso_t", "sw_desembolso", "nro_pagos_realizados", "ultima_fecha_pago"];

    public function getUltimaFechaPagoAttribute()
    {
        $ultimo_plan = GrupoPlanPago::where("grupo_id", $this->id)->orderBy("nro_cuota", "desc")->get()->first();
        if ($ultimo_plan->fecha_pago) {
            return date("d/m/Y", strtotime($ultimo_plan->fecha_pago));
        }
        return "S/D";
    }

    public function getNroPagosRealizadosAttribute()
    {
        $nro_pagos = GrupoPlanPago::where("grupo_id", $this->id)->where("cancelado", "SI")->get();
        return count($nro_pagos);
    }

    public function getSwDesembolsoAttribute()
    {
        if ($this->fecha_desembolso) {
            $fecha_actual = date("Y-m-d");
            if ($this->fecha_desembolso == $fecha_actual) {
                return true;
            }
        }
        return false;
    }

    public function getFechaDesembolsoTAttribute()
    {
        if ($this->fecha_desembolso) {
            return date("d-m-Y", strtotime($this->fecha_desembolso));
        }
        return null;
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d-m-Y", strtotime($this->fecha_registro));
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function o_desembolso()
    {
        return $this->hasOne(Desembolso::class, 'grupo_id');
    }

    public function user_desembolso()
    {
        return $this->belongsTo(User::class, 'user_desembolso_id');
    }

    public function user_aprobado()
    {
        return $this->belongsTo(User::class, 'user_aprobado_id');
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
        return $this->hasMany(Pago::class, 'grupo_id')->orderBy("id", "desc");
    }
}
