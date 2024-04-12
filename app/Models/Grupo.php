<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

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

    protected $appends = ["fecha_registro_t", "fecha_desembolso_t", "sw_desembolso", "nro_pagos_realizados", "ultima_fecha_pago", "ultimo_pago", "pagos_tiempo", "pagos_mora", "pagos_pendiente"];

    public function getPagosTiempoAttribute()
    {
        $pagos = Pago::where("grupo_id", $this->id)->get();

        $contador = 0;
        $ultimo_pago = null;
        foreach ($pagos as $pago) {
            $ultimo_pago = $pago;
            if ($pago->nro_cuota != 0 && (float)$pago->monto_mora == 0) {
                $contador++;
            } else {
                if ($ultimo_pago->nro_cuota == 0 && (float)$pago->monto_mora == 0) {
                    $plazo = $pago->grupo->plazo;
                    $contador += (int)$plazo - (int)$ultimo_pago->nro_cuota;
                }
            }
        }
        return $contador;
    }
    public function getPagosMoraAttribute()
    {
        $pagos = Pago::where("grupo_id", $this->id)->get();

        $contador = 0;
        $ultimo_pago = null;
        foreach ($pagos as $pago) {
            $ultimo_pago = $pago;
            if ($pago->nro_cuota != 0 && (float)$pago->monto_mora > 0) {
                $contador++;
            } else {
                if ($ultimo_pago->nro_cuota == 0 && (float)$pago->monto_mora > 0) {
                    $plazo = $pago->grupo->plazo;
                    $contador += (int)$plazo - (int)$ultimo_pago->nro_cuota;
                }
            }
        }
        return $contador;
    }

    public function getPagosPendienteAttribute()
    {
        $plan_pagos = GrupoPlanPago::where("grupo_id", $this->id)->where("cancelado", "NO")->get();
        if (count($plan_pagos) == 0) {
            $grupo = Grupo::find($this->id);
            $grupo->finalizado = 1;
            $grupo->save();
            $grupo->prestamos()->update(["finalizado" => 1]);
        }
        return count($plan_pagos);
    }


    public function getUltimoPagoAttribute()
    {
        $pago = Pago::where("grupo_id", $this->id)->orderBy("id", "desc")->get()->first();
        return $pago;
    }

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
